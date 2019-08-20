//
//  FeedViewModel.swift
//  RankUp
//
//  Created by Miguel Rojas on 7/28/19.
//

import Foundation

final class FeedViewModel {
    
    var feedbackFeed: FeedbackFeed?
    private let apiClient: APIClientFacade
    
    // MARK: - Computed Properties
    
    var numberOfFeeds: Int {
        return filteredFeedbacks?.count ?? 0
    }
    
    var filteredFeedbacks: [Feedback]? {
        guard let feedbacks = feedbackFeed?.feedbacks else { return nil }
        
        return feedbacks.filter( { !$0.isFlaggedByuser } )
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
                            let flaggedFeedback = updatedFeedback as? UpdatedFeedBack,
                            let updatedFeedbackIndex = feedBacks.firstIndex(where: {$0.id == flaggedFeedback.feedback }) {
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
    
    func likeFeedback(at index: Int, completion: @escaping (Bool, Error?) -> Void) {
        if let feedBack = feedback(at: index), let feedbackID = feedBack.id {
            apiClient.likeFeedback(feedbackId: feedbackID) { [weak self] result in
                DispatchQueue.main.async {
                    guard let strongSelf = self else { return }
                    switch result {
                    case .success(let updatedFeedback):
                        if var feedBacks = strongSelf.feedbackFeed?.feedbacks,
                            let likedFeedback = updatedFeedback as? UpdatedFeedBack,
                            let updatedFeedbackIndex = feedBacks.firstIndex(where: {$0.id == likedFeedback.feedback }) {
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
    
    func isLikedFeedback(at index: Int) -> Bool {
        guard let feedBack = feedback(at: index) else {
            return false
        }
        return feedBack.isLikedByuser ?? false
    }
        
    // MARK: - Datasource
    
    func feedback(at index: Int) -> Feedback? {
        guard let feedbacks = filteredFeedbacks, index >= 0 && index < feedbacks.count else { return nil }
        
        return feedbacks[index]
    }
    
    /* Test Scenario to give feedback.
     This should be moved to the search results table or fucking profile view with a couple of buttons with options (recognise/improve)
     */
    func feedbackModel(at index: Int) -> FeedbackModel? {
        let giveFeedbackModel = feedback(at: index)
        guard
            let msid = giveFeedbackModel?.to?.msid,
            let userName = giveFeedbackModel?.to?.name,
            let points = giveFeedbackModel?.to?.rank else { return nil }
        
        return FeedbackModel(userMSID: msid, userName: userName, userRank: String(describing: points).withOrdinalSuffix())
    }
    
}
