//
//  MainViewModel.swift
//  RankUp
//
//  Created by Miguel Rojas on 7/28/19.
//

import Foundation

enum AuthenticationState {
    case registered
    case unregistered
    case error
}

final class MainViewModel {
    
    // MARK: - Initializers
    
    private let apiClient: APIClientFacade
    var userModel: LoggedInUser?
    var unregisteredUserModel: UnregisteredUser?
    
    init(apiClient: APIClientFacade) {
        self.apiClient = apiClient
    }
    
    // MARK: - Interface
    
    func fetchInitialData(completion: @escaping (AuthenticationState, Error?) -> Void) {
        apiClient.userInformation { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let loggedInUser, let nonRegisterUser):
                    if let nonRegisterUser = nonRegisterUser {
                        self?.unregisteredUserModel = nonRegisterUser
                        completion(.unregistered, nil)
                    } else {
                        self?.userModel = loggedInUser
                        completion(.registered, nil)
                    }
                case .failure(let error):
                    completion(.error, error)
                }
            }
        }
    }
    
}
