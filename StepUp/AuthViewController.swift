//
//  AuthViewController.swift
//  StepUp
//
//  Created by Daniel Bernal on 7/14/19.
//

import UIKit
import MSAL

class AuthViewController: UIViewController {

    // MARK: MSGraph Authentication Settings
    let kClientID = "31e5cf9f-5655-43df-bf98-9732798c0a9d"
    
    // Additional variables for Auth and Graph API
    let kScopes: [String] = ["https://graph.microsoft.com/user.read",
                             "https://graph.microsoft.com/analytics.read",
                             "https://graph.microsoft.com/calendars.read",
                             "https://graph.microsoft.com/people.read"]
    let kAuthority = "https://login.microsoftonline.com/endava.com/v2.0/.well-known/openid-configuration"
    
    let kAPIURI = "http://10.0.0.20:1337"
    
    // MARK: MSGraph Authentication Variables
    var accessToken = String()
    var applicationContext : MSALPublicClientApplication?
    
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.text = "Initializing"
        do {
            try initMSAL()
        } catch {
            print("Could not initialize MSAL")
        }
        

    }
    
    // Inits MSAL
    func initMSAL() throws {
        guard let authorityURL = URL(string: kAuthority) else {
            print("Unable to create authority URL")
            return
        }
        
        let authority = try MSALAADAuthority(url: authorityURL)
        let msalConfiguration = MSALPublicClientApplicationConfig(clientId: kClientID, redirectUri: nil, authority: authority)
        self.applicationContext = try MSALPublicClientApplication(configuration: msalConfiguration)
        authenticateUser()
    }
    
    // Get current account from cache
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
        
        statusLabel.text = "Authenticating"
        
        // Check to see if we have a current logged in account.
        // If we don't, then we need to sign someone in.
        guard let currentAccount = self.currentAccount() else {
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
    
    // Token acquiring
    func acquireTokenInteractively() {
        
        guard let applicationContext = self.applicationContext else { return }
        applicationContext.acquireToken(forScopes: kScopes, loginHint: nil, promptType: .consent, extraQueryParameters: ["domain_hint": "endava.com"]) { (result, error) in
            if let error = error {
                print("Could not acquire token: \(error)")
                return
            }
            
            guard let result = result else {
                print("Could not acquire token: No result returned")
                return
            }
            self.accessToken = result.accessToken
            self.fetchProfile()
        }
    }
    
    func acquireTokenSilently(_ account : MSALAccount!) {
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
            print("Refreshed Access token is \(self.accessToken)")
            self.fetchProfile()
        }
    }
    
    
    // Registers the User in the StepUP database or updates the access token
    func fetchProfile() {
        DispatchQueue.main.async{
            self.statusLabel.text = "Syncing Stats"
        }

        let path = "/me"
        let url = URL(string:
            kAPIURI + path)
        var request = URLRequest(url: url!)
        
        // Set the Authorization header for the request. We use Bearer tokens, so we specify Bearer + the token we got from the result
        request.setValue("Bearer \(self.accessToken)", forHTTPHeaderField: "Authorization")
        
        AreaRepository().retrieveAreaList(API.area(self.accessToken).request()) { (result) in
            switch result {
            case .success(let areas):
                print(areas)
            case .failure(let error):
                print(error)
            }
        }
        
        LocationRepository().retrieveLocationList(API.location(self.accessToken).request()) { (result) in
            switch result {
            case .success(let locations):
                print(locations)
            case .failure(let error):
                print(error)
            }
        }
        
        LoggedInUserRepository().retrieveUserInformation(API.loggedInUser(self.accessToken).request()) { (result) in
            switch result {
            case .success(let loggedInUser, let nonRegisterUser):
                if let nonRegisterUser = nonRegisterUser {
                    print("\(nonRegisterUser)")
                    self.registerUser(token: self.accessToken)
                } else {
                    print("\(loggedInUser)")
                }
            case .failure(let error):
                print(error)
            }
        }
        
        let params = ["from": "1563757462558",
                      "to": "1663757462558",
                      "page":"1",
                      "value":"12345678",
                      "user": "5d37ee0b68f99c7a7d5779f6",
                      "private": "true",
                      "pinned":"false"]
        
        FeedbackRepository().retrieveFeedbacks(API.feedback(self.accessToken).request(parameters: params)) { (result) in
            switch result {
            case .success(let feedback):
                print("\(feedback)")
            case .failure(let error):
                print(error)
            }
        }
        
        let rankFilter = ["page": "1",
                          "value": "Open",
                          "location": "Bogotá",
                          "area": "Development"]
        
        RankRepository().retrieveRanks(API.rank(self.accessToken).request(parameters: rankFilter)) { (result) in
            switch result {
            case .success(let ranks):
                print("\(ranks)")
            case .failure(let error):
                print(error)
            }
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Couldn't get API result: \(error)")
                return
            }
            guard let result = try? JSONSerialization.jsonObject(with: data!, options: []) else {
                print("Couldn't deserialize result JSON")
                return
            }
            print("Result from API: \(result))")
            DispatchQueue.main.async{
                self.statusLabel.text = "Ready!"
            }
            }.resume()
    }
    
    private func registerUser(token: String) {
        let body = ["location": "5d34ff91fca3b9104a74c2b0",
                    "area": "5d350b963d25dc15994fdf8e"]
        
        LoggedInUserRepository().registerUser(API.registerUser(token, body).request(), completion: { (result) in
            switch result {
            case .success(let createdLoggedInUser):
                print("\(createdLoggedInUser)")
            case .failure(let error):
                print(error)
            }
        })
    }
}
