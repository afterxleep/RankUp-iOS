//
//  AuthenticationViewController.swift
//  StepUp
//
//  Created by Daniel Bernal on 7/14/19.
//

import MSAL

final class AuthenticationViewController: UIViewController {
    
    // MARK: MSGraph Authentication Settings
    let kClientID = "31e5cf9f-5655-43df-bf98-9732798c0a9d"
    
    // Additional variables for Auth and Graph API
    let kScopes: [String] = ["https://graph.microsoft.com/user.read",
                             "https://graph.microsoft.com/analytics.read",
                             "https://graph.microsoft.com/calendars.read",
                             "https://graph.microsoft.com/people.read"]
    let kAuthority = "https://login.microsoftonline.com/endava.com/v2.0/.well-known/openid-configuration"
    
    // MARK: MSGraph Authentication Variables
    var accessToken = String()
    var applicationContext : MSALPublicClientApplication?
    
    @IBOutlet weak private var statusLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.text = "Initializing"
        do {
            try initMSAL()
        } catch {
            print("Could not initialize MSAL")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SignupViewController {
            destination.viewModel.accessToken = accessToken
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
            
            self.routeToSignupView()
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
            
            self.routeToSignupView()
        }
    }
    
    private func routeToSignupView() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: K.Segues.registrationSegue, sender: nil)
        }
    }
    
}
