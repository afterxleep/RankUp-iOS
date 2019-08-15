//
//  BestsViewModel.swift
//  StepUp
//
//  Created by Miguel Rojas on 7/28/19.
//

import Foundation

final class BestsViewModel {
    
    var bestsFeed: FeedbackFeed?
    private let apiClient: APIClientFacade
    
    // MARK: - Computed Properties
    
    var numberOfBests: Int {
        return bestsFeed?.feedbacks?.count ?? 0
    }
    
    // MARK: - Initializers
    
    init(apiClient: APIClientFacade) {
        self.apiClient = apiClient
    }
    
    // MARK: - Interface
    
    func fetchBestsFeeds(completion: @escaping (Error?) -> Void) {
        let filter: [String: String] = [FeedbackFilterKeys.isPinnedKey: "true"]
        apiClient.feedbacks(filter: filter) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let feed):
                    print(feed.feedbacks)
                    self?.bestsFeed = feed
                    completion(nil)
                case .failure(let error):
                    print("Holly shit: \(error)")
                    completion(error)
                }
            }
        }
    }
    
    func bestFeed(at index: Int) -> Feedback? {
        guard let feedbacks = bestsFeed?.feedbacks, index >= 0 && index < feedbacks.count else { return nil }
        
        return feedbacks[index]
    }
    
}
