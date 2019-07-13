import UIKit
import MSAL

class ViewController: UIViewController, UITextFieldDelegate, URLSessionDelegate {
    
    // MARK: MSGraph Authentication Settings
    let kClientID = "31e5cf9f-5655-43df-bf98-9732798c0a9d"
    
    // Additional variables for Auth and Graph API
    let kGraphURI = "https://graph.microsoft.com/v1.0/me/"
    let kScopes: [String] = ["https://graph.microsoft.com/user.read",
                             "https://graph.microsoft.com/analytics.read",
                             "https://graph.microsoft.com/calendars.read",
                             "https://graph.microsoft.com/people.read"]
    let kAuthority = "https://login.microsoftonline.com/0b3fc178-b730-4e8b-9843-e81259237b77"
    
    
    // MARK: MSGraph Authentication Settings
    var accessToken = String()
    var applicationContext : MSALPublicClientApplication?

    
    // MARK: App LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try self.initMSAL()
        } catch let error {
            print("Unable to create Application Context \(error)")
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}


// MARK: MSAL Initialization

extension ViewController {
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
}


// MARK: Authentication and getting token
extension ViewController {
    
    func authenticateUser() {
        
        // Check to see if we have a current logged in account.
        // If we don't, then we need to sign someone in.
        guard let currentAccount = self.currentAccount() else {
            acquireTokenInteractively()
            return
        }
        acquireTokenSilently(currentAccount)
    }
    
    
    func acquireTokenInteractively() {
        
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
            print("Access token is \(self.accessToken)")
            self.getContentWithToken()
        }
    }
    
    func acquireTokenSilently(_ account : MSALAccount!) {
        guard let applicationContext = self.applicationContext else { return }
        let parameters = MSALSilentTokenParameters(scopes: kScopes, account: account)
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
            self.getContentWithToken()
        }
    }
    
    
    
    
    /**
     This will invoke the call to the Microsoft Graph API. It uses the
     built in URLSession to create a connection.
     */
    
    func getContentWithToken() {
        
        /*
        let path = "/people/" // Specify the Graph API endpoint
        let url = URL(string: kGraphURI + path)
        var request = URLRequest(url: url!)
        
        // Set the Authorization header for the request. We use Bearer tokens, so we specify Bearer + the token we got from the result
        request.setValue("Bearer \(self.accessToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                //self.updateLogging(text: "Couldn't get graph result: \(error)")
                return
            }
            
            guard let result = try? JSONSerialization.jsonObject(with: data!, options: []) else {
                
                //self.updateLogging(text: "Couldn't deserialize result JSON")
                return
            }
            
            //self.updateLogging(text: "Result from Graph: \(result))")
            
            }.resume()
         */
    }

}


// MARK: Get account and removing cache

extension ViewController {
    
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
    
    
    func signOut() {
        guard let applicationContext = self.applicationContext else { return }
        guard let account = self.currentAccount() else { return }
        do {
            try applicationContext.remove(account)
            self.accessToken = ""
        } catch let error as NSError {
            print("Received error signing account out: \(error)")
        }
    }
}
