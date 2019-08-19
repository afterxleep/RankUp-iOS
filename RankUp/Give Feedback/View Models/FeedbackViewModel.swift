//
//  FeedbackViewModel.swift
//  RankUp
//
//  Created by Miguel D Rojas Cortés on 8/18/19.
//

import Foundation

struct FeedbackViewModel {
    
    //MARK: - Stored Properties
    
    var companyValue: Value?
    var feedback: FeedbackModel?
    var feedBackType: FeedbackType?
    var isPositive: Bool = true
    
    private let apiClient: APIClientFacade
    
    //MARK: - Initializers
    
    init(apiClient: APIClientFacade) {
        self.apiClient = apiClient
    }
    
    //MARK: - Inteface
    
    func sendFeedBack(comment: String, isPublic: Bool = true, completion: @escaping () -> Void) {
        guard
            let leFeedback = feedback,
            let value = companyValue
            else { return }
        
        let feedbackBody = CreateFeedbackBody(msid: leFeedback.userMSID,
                                              value: value.id,
                                              comment: comment,
                                              isPublic: isPublic,
                                              isPositive: feedBackType == .recognise)
        
        apiClient.createFeedback(body: feedbackBody) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let updatedFeedback):
                    print("Naaa chimba ese feedback: \(updatedFeedback)")
                    completion()
                case .failure(let error):
                    print("Ah pero que nea \(error.localizedDescription)")
                    completion()
                }
            }
        }
    }
    
}
