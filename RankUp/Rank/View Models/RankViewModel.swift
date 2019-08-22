//
//  RankViewModel.swift
//  RankUp
//
//  Created by Miguel D Rojas Cortés on 8/20/19.
//

import Foundation

final class RankViewModel {
    
    // MARK: - Stored Properties
    
    private let apiClient: APIClientFacade
    var rankedUsers = [Contact]()
    
    // MARK: - Computed Properties
    
    var numberOfUsers: Int {
        return rankedUsers.count
    }
    
    // MARK: - Initializers
    
    init(apiClient: APIClientFacade) {
        self.apiClient = apiClient
    }
    
    // MARK: - Interface
    
    func fetchRankData(completion: @escaping (Bool, String?) -> Void) {
        apiClient.userSearch(filter: ["sort": "score DESC"]) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self?.rankedUsers = users
                    completion(true, nil)
                case .failure(let error):
                    completion(false, error.localizedDescription)
                }
            }
        }
    }
    
    func user(at index: Int) -> Contact? {
        guard index >= 0 && index < rankedUsers.count else { return nil }
        return rankedUsers[index]
    }
    
}
