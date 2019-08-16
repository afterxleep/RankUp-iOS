//
//  FeedViewModel.swift
//  RankUp
//
//  Created by Miguel Rojas on 7/28/19.
//

import Foundation

final class FeedViewModel {
    
    var feedbackFeed: FeedbackFeed?
    
    var filteredFeedbacks: [Feedback]? {
        guard let feedbacks = feedbackFeed?.feedbacks else { return nil }
        
        return feedbacks.filter( { !$0.isFlaggedByuser } )
    }
    
    private let apiClient: APIClientFacade
    
    // MARK: - Computed Properties
    
    var numberOfFeeds: Int {
        return filteredFeedbacks?.count ?? 0
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
    
    func flagFeedback(at index: Int, completion: @escaping (Bool, Error?) -> Void) {
        if let feedBack = feedback(at: index), let feedbackID = feedBack.id {
            apiClient.flagFeedback(feedbackId: feedbackID) { [weak self] result in
                DispatchQueue.main.async {
                    guard let strongSelf = self else { return }
                    switch result {
                    case .success(let updatedFeedback):
                        if var feedBacks = strongSelf.feedbackFeed?.feedbacks,
                            let updatedFeedbackIndex = feedBacks.firstIndex(where: {$0.id == updatedFeedback.feedback }) {
                            feedBacks[updatedFeedbackIndex].isFlaggedByuser = true
                            var updatedFeedbackFeed = strongSelf.feedbackFeed
                            updatedFeedbackFeed?.feedbacks = feedBacks
                            strongSelf.feedbackFeed = updatedFeedbackFeed
                            completion(true, nil)
                        }
                        completion(false, nil)
                    case .failure(let error):
                        print("Failed to flag feed: \(error.localizedDescription)")
                        completion(false, error)
                    }
                }
            }
        }
    }
    
    // MARK: - Datasource
    
    func feedback(at index: Int) -> Feedback? {
        guard let feedbacks = filteredFeedbacks, index >= 0 && index < feedbacks.count else { return nil }
        
        return feedbacks[index]
    }
    
}
