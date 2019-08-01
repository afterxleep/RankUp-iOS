//
//  AuthViewController.swift
//  StepUp
//
//  Created by Daniel Bernal on 7/14/19.
//

import UIKit
import MSAL

class AuthViewController: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    
    lazy var commonApi: APIClientService = {
        let api = APIClientRepository()
        api.msalDelegate = self
        
        return api
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchProfile()
    }
    
    // Registers the User in the StepUP database or updates the access token
    func fetchProfile() {
        
        commonApi.allCompanyAreas { (result) in
            switch result {
            case .success(let areas):
                print(areas)
            case .failure(let error):
                print(error)
            }
        }
        
        commonApi.allCompanyLocations { (result) in
            switch result {
            case .success(let locations):
                print(locations)
            case .failure(let error):
                print(error)
            }
        }
        
        commonApi.userInformation { (result) in
            switch result {
            case .success(let loggedInUser, let nonRegisterUser):
                if let nonRegisterUser = nonRegisterUser {
                    print("\(nonRegisterUser)")
                    self.registerUser()
                } else {
                    print("\(loggedInUser)")
                }
            case .failure(let error):
                print(error)
            }
        }

        commonApi.rankings(page: "1",
                           value: "Open",
                           location: "5d34ff91fca3b9104a74c2b0",
                           area: "5d350b963d25dc15994fdf8e") { (result) in
                            switch result {
                            case .success(let ranks):
                                print("\(ranks)")
                            case .failure(let error):
                                print(error)
                            }
        }
    }
    
    private func registerUser() {
        commonApi.registerUser(location: "5d34ff91fca3b9104a74c2b0", area: "5d350b963d25dc15994fdf8e") { (result) in
            switch result {
            case .success(let createdLoggedInUser):
                print("\(createdLoggedInUser)")
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension AuthViewController: MSALDelegate {
    func initializing(_ repository: MSALRepository) {
        DispatchQueue.main.async{
            self.statusLabel.text = "Initializing"
        }
    }
    
    func authenticating(_ repository: MSALRepository) {
        DispatchQueue.main.async{
            self.statusLabel.text = "Authenticating"
        }
    }
    
    func accessTokenDidAcquired(_ repository: MSALRepository) {
        DispatchQueue.main.async{
            self.statusLabel.text = "Syncing Stats"
        }
    }
    
    
}
