//
//  FeedBackTypeViewModel.swift
//  RankUp
//
//  Created by Miguel D Rojas Cortés on 8/17/19.
//

import Foundation

final class FeedBackTypeViewModel {
    
    //MARK: - Stored Properties
    
    private let apiClient: APIClientFacade
        
    var feedback: FeedbackModel?    
    var endavaValues = [Value]()
    
    //MARK: - Initializers
    
    init(apiClient: APIClientFacade) {
        self.apiClient = apiClient
    }
    
    //MARK: - Interface
    
    func valueForIndex(index: Int) -> Value? {
        guard index >= 0 && index < endavaValues.count else { return nil }
        
        return endavaValues[index]
    }
    
    func fetchCompanyValues(completion: @escaping () -> Void) {
        apiClient.allCompanyValues { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let values):
                    self?.endavaValues = values
                    completion()
                case .failure(let error):
                    print("Les Values faillaron \(error)")
                    completion()
                }
            }
        }
    }
    
}
