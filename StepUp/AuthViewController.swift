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
    
    lazy var repository: MSALRepository = {
        let repository = MSALRepository()
        repository.delegate = self
        
        return repository
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repository.retrieveSecurityToken { (result) in
            switch result {
            case .success(let token):
                self.fetchProfile(token: token)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // Registers the User in the StepUP database or updates the access token
    func fetchProfile(token: String) {
        
        AreaRepository().retrieveAreaList(API.area(token).request()) { (result) in
            switch result {
            case .success(let areas):
                print(areas)
            case .failure(let error):
                print(error)
            }
        }
        
        LocationRepository().retrieveLocationList(API.location(token).request()) { (result) in
            switch result {
            case .success(let locations):
                print(locations)
            case .failure(let error):
                print(error)
            }
        }
        
        LoggedInUserRepository().retrieveUserInformation(API.loggedInUser(token).request()) { (result) in
            switch result {
            case .success(let loggedInUser, let nonRegisterUser):
                if let nonRegisterUser = nonRegisterUser {
                    print("\(nonRegisterUser)")
                    self.registerUser(token: token)
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
        
        FeedbackRepository().retrieveFeedbacks(API.feedback(token).request(parameters: params)) { (result) in
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
        
        RankRepository().retrieveRanks(API.rank(token).request(parameters: rankFilter)) { (result) in
            switch result {
            case .success(let ranks):
                print("\(ranks)")
            case .failure(let error):
                print(error)
            }
        }
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
