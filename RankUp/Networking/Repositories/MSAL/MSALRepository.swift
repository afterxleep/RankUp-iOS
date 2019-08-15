//
//  MSALRepository.swift
//  RankUp
//
//  Created by Juan combariza on 7/31/19.
//

import Foundation
import MSAL

final class MSALRepository: MSALService {

    // MARK: Constants
    
    private let kClientID               = "31e5cf9f-5655-43df-bf98-9732798c0a9d"
    private let kScopes: [String]       = ["https://graph.microsoft.com/user.read",
                                           "https://graph.microsoft.com/analytics.read",
                                           "https://graph.microsoft.com/calendars.read",
                                           "https://graph.microsoft.com/people.read"]
    private let kAuthority              = "https://login.microsoftonline.com/endava.com/v2.0/.well-known/openid-configuration"
    private let domainHintKey           = "domain_hint"
    private let domainHintValue         = "endava.com"
    
    // MARK: Variables
    
    private var applicationContext : MSALPublicClientApplication?
    weak var delegate: MSALDelegate?
    
    // MARK: - get token
    
    func retrieveSecurityToken(completion: @escaping RetrieveTokenCompletion) {
        delegate?.initializing(self)
        do {
            try self.initMSAL(completion: completion)
        } catch {
            completion(.failure(.unableToInitializeMSAL))
        }
    }
    
    func retrieveProfilePhoto(_ request: URLRequest?, completion: @escaping RetrieveProfilePhotoCompletion) {
        guard let request = request else {
            completion(.failure(.unableToMakeRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            switch BasicRequest.handleBasicResponse(with: data, response: response, error: error) {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(data))
            }
        })
        
        task.resume()
    }
    
    func logOutUser() {
        guard let applicationContext = self.applicationContext else { return }
        guard let account = self.currentAccount() else { return }
        do {
            try applicationContext.remove(account)
        } catch let error as NSError {
            print("Received error signing account out: \(error)")
        }
    }
    
    // MARK: - Auxiliary methods
    
    private func initMSAL(completion: @escaping RetrieveTokenCompletion) throws {
        guard let authorityURL = URL(string: kAuthority) else {
            completion(.failure(.unableToCreateAuthorityURL))
            return
        }
        
        let authority = try MSALAADAuthority(url: authorityURL)
        let msalConfiguration = MSALPublicClientApplicationConfig(clientId: kClientID, redirectUri: nil, authority: authority)
        applicationContext = try MSALPublicClientApplication(configuration: msalConfiguration)
        
        authenticateUser(completion: completion)
    }
    
    private func authenticateUser(completion: @escaping RetrieveTokenCompletion) {
        delegate?.authenticating(self)
        
        guard let currentAccount = currentAccount() else {
            acquireTokenInteractively(completion: completion)
            return
        }
        
        acquireTokenSilently(currentAccount, completion: completion)
    }
    
    private func currentAccount() -> MSALAccount? {
        guard let applicationContext = self.applicationContext else { return nil }
        
        do {
            let cachedAccounts = try applicationContext.allAccounts()
            if !cachedAccounts.isEmpty {
                return cachedAccounts.first
            }
        } catch let error as NSError {
            print("No accounts stored in cache: \(error)")
        }
        
        return nil
    }
    
    private func acquireTokenInteractively(completion: @escaping RetrieveTokenCompletion) {
        guard let applicationContext = self.applicationContext else { return }
        
        applicationContext.acquireToken(forScopes: kScopes,
                                        loginHint: nil,
                                        promptType: .consent,
                                        extraQueryParameters: [domainHintKey: domainHintValue]) { [weak self] (result, error) in
                                            guard let strongSelf = self else { return }
                                            
                                            if  error != nil {
                                                completion(.failure(.unableToAcquireToken))
                                                return
                                            }
                                            
                                            guard let result = result else {
                                                completion(.failure(.unableToAcquireToken))
                                                return
                                            }
                                            
                                            strongSelf.delegate?.accessTokenDidAcquired(strongSelf)
                                            completion(.success(result.accessToken))
        }
    }
    
    private func acquireTokenSilently(_ account : MSALAccount!, completion: @escaping RetrieveTokenCompletion) {
        guard let applicationContext = self.applicationContext else { return }
        
        let parameters = MSALSilentTokenParameters(scopes: kScopes, account: account)
        print(parameters)
        applicationContext.acquireTokenSilent(with: parameters) { [weak self] (result, error) in
            guard let strongSelf = self else { return }
            
            if let error = error as NSError?, error.domain == MSALErrorDomain, error.code == MSALError.interactionRequired.rawValue {
                strongSelf.acquireTokenInteractively(completion: completion)
                
                return
            }
            
            guard let result = result else {
                completion(.failure(.unableToAcquireToken))
                return
            }
            
            strongSelf.delegate?.accessTokenDidAcquired(strongSelf)
            completion(.success(result.accessToken))
        }
    }
}
