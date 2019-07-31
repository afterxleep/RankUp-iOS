//
//  MSALRepository.swift
//  StepUp
//
//  Created by Juan combariza on 7/31/19.
//

import Foundation
import MSAL

final class MSALRepository {
    
    // MARK: MSGraph Authentication Settings
    
    private let kClientID = "31e5cf9f-5655-43df-bf98-9732798c0a9d"
    private let kScopes: [String] = ["https://graph.microsoft.com/user.read",
                             "https://graph.microsoft.com/analytics.read",
                             "https://graph.microsoft.com/calendars.read",
                             "https://graph.microsoft.com/people.read"]
    private let kAuthority = "https://login.microsoftonline.com/endava.com/v2.0/.well-known/openid-configuration"
    
    // MARK: MSGraph Authentication Variables
    
    var accessToken: String?
    var applicationContext : MSALPublicClientApplication?
    
    // MARK: - Initialazer
    
    init() {
        do {
            try self.initMSAL()
        } catch {
            print("Could not initialize MSAL")
        }
    }
    
    // MARK: - Authenticate user
    
    func currentAccount() -> MSALAccount? {
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
    
    func authenticateUser() {
        guard let currentAccount = currentAccount() else {
            acquireTokenInteractively()
            return
        }
        
        acquireTokenSilently(currentAccount)
    }
    
    func logOutUser() {
        guard let applicationContext = self.applicationContext else { return }
        guard let account = self.currentAccount() else { return }
        do {
            try applicationContext.remove(account)
            self.accessToken = ""
        } catch let error as NSError {
            print("Received error signing account out: \(error)")
        }
    }
    
    // MARK: - Auxiliary methods
    
    private func initMSAL() throws {
        guard let authorityURL = URL(string: kAuthority) else {
            print("Unable to create authority URL")
            return
        }
        
        let authority = try MSALAADAuthority(url: authorityURL)
        let msalConfiguration = MSALPublicClientApplicationConfig(clientId: kClientID, redirectUri: nil, authority: authority)
        applicationContext = try MSALPublicClientApplication(configuration: msalConfiguration)
    }
    
    private func acquireTokenInteractively() {
        
        guard let applicationContext = self.applicationContext else { return }
        
        let parameters = MSALInteractiveTokenParameters(scopes: kScopes)
        applicationContext.acquireToken(with: parameters) { (result, error) in
            if let error = error {
                print("Could not acquire token: \(error)")
                return
            }
            
            guard let result = result else {
                print("Could not acquire token: No result returned")
                return
            }
            
            self.accessToken = result.accessToken
        }
    }
    
    private func acquireTokenSilently(_ account : MSALAccount!) {
        guard let applicationContext = self.applicationContext else { return }
        
        let parameters = MSALSilentTokenParameters(scopes: kScopes, account: account)
        print(parameters)
        applicationContext.acquireTokenSilent(with: parameters) { (result, error) in
            if let error = error {
                let nsError = error as NSError
                if (nsError.domain == MSALErrorDomain) {
                    if (nsError.code == MSALError.interactionRequired.rawValue) {
                        DispatchQueue.main.async {
                            self.acquireTokenInteractively()
                        }
                        return
                    }
                }
                print("Could not acquire token silently: \(error)")
                return
            }
            guard let result = result else {
                print("Could not acquire token: No result returned")
                return
            }
            
            self.accessToken = result.accessToken
        }
    }
}
