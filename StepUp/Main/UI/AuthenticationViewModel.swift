//
//  AuthenticationViewModel.swift
//  StepUp
//
//  Created by Miguel Rojas on 7/28/19.
//

import Foundation

struct AuthenticationViewModel {
    
    // MARK: - Initializers
    
    let apiClient: LoggedInUserRepository
    
    init(apiClient: LoggedInUserRepository) {
        self.apiClient = apiClient
    }
    
}
