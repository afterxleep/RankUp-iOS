//
//  RankViewModel.swift
//  RankUp
//
//  Created by Miguel D Rojas Cortés on 8/20/19.
//

import Foundation

final class RankViewModel {
    
    private let apiClient: APIClientFacade
    
    init(apiClient: APIClientFacade) {
        self.apiClient = apiClient
    }
    
    func fetchRankData() {
        apiClient.rankings(filter: nil) { result in
            switch result {
            case .success(let rank):
                print(rank)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
