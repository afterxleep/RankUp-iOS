//
//  MainViewController.swift
//  RankUp
//
//  Created by Daniel Bernal on 7/14/19.
//

import MSAL

final class MainViewController: UIViewController {
    
    private struct Constants {
        static let firstLineTitleAttrs: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
    }
    
    @IBOutlet weak private var statusLabel: UILabel!
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Computed Properties
    
    lazy private var viewModel: MainViewModel? = {
        let apiClient = APIClient()
        apiClient.msalDelegate = self
        
        return MainViewModel(apiClient: apiClient)
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
            self?.activityIndicator.stopAnimating()
            switch authState {
            case .unregistered:
                self?.performSegue(withIdentifier: K.Segues.registrationSegue, sender: nil)
            case .registered:
                self?.performSegue(withIdentifier: K.Segues.feedSegue, sender: nil)
            case .error:
                print("We are fucked up niggas...")
            }
        }
    }
    
}

extension MainViewController: MSALDelegate {
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
