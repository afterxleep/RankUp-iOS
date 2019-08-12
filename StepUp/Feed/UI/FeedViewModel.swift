//
//  FeedViewModel.swift
//  StepUp
//
//  Created by Miguel Rojas on 7/28/19.
//

import Foundation

final class FeedViewModel {
    
    var feedbackFeed: FeedbackFeed?
    private let apiClient: APIClientFacade
    
    // MARK: - Computed Properties
    
    var numberOfFeeds: Int {
        return feedbackFeed?.feedbacks?.count ?? 0
    }
    
    // MARK: - Initializers
    
    init(apiClient: APIClientFacade) {
        self.apiClient = apiClient
    }
    
    // MARK: - Interface
    
    func fetchFeeds(completion: @escaping (Error?) -> Void) {
        apiClient.feedbacks(filter: nil) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let feed):
                    self?.feedbackFeed = feed
                    completion(nil)
                case .failure(let error):
                    print("Holly shit: \(error)")
                    completion(error)
                }
            }
        }
    }
    
    func feedback(at index: Int) -> Feedback? {
        guard let feedbacks = feedbackFeed?.feedbacks, index > 0 && index <= feedbacks.count else { return nil }
        
        return feedbacks[index]
    }
    
}
