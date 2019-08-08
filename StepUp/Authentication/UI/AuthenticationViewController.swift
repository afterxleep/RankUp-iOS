//
//  AuthenticationViewController.swift
//  StepUp
//
//  Created by Daniel Bernal on 7/14/19.
//

import MSAL

final class AuthenticationViewController: UIViewController {
    
    @IBOutlet weak private var statusLabel: UILabel!
    
    lazy private var viewModel: AuthenticationViewModel? = {
        let apiClient = APIClient()
        apiClient.msalDelegate = self
        
        return AuthenticationViewModel(apiClient: apiClient)
    }()
    
    // MARK: - Computed Properties
    
    lazy var commonApi: APIClientFacade = {
        let api = APIClient()
        api.msalDelegate = self
        
        return api
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkAuthenticationState()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? SignupViewController {
            controller.viewModel.userModel = viewModel?.unregisteredUserModel
        }
    }
    
    // MARK: - Private
    
    private func checkAuthenticationState() {
        viewModel?.fetchInitialData { [weak self] authState, error in
            switch authState {
            case .unregistered:
                self?.performSegue(withIdentifier: K.Segues.registrationSegue, sender: nil)
            case .registered:
                self?.performSegue(withIdentifier: K.Segues.feedSegue, sender: nil)
            case .error:
                print("We are fucked niggas...")
            }
        }
    }
    
}

extension AuthenticationViewController: MSALDelegate {
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
