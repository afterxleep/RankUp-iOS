//
//  FeedbackService.swift
//  RankUp
//
//  Created by Juan combariza on 7/27/19.
//

import Foundation

typealias RetrieveFeedbackCompletion = (Result<FeedbackFeed, RequestError>) -> Void
typealias FeedbackCompletion = (Result<Any, RequestError>) -> Void

protocol FeedbackService {
    func retrieveFeedbacks(_ request: URLRequest?, completion: @escaping RetrieveFeedbackCompletion)
    func createFeedbacks(_ request: URLRequest?, completion: @escaping FeedbackCompletion)
    func likeFeedback(_ request: URLRequest?, completion: @escaping FeedbackCompletion)
    func flagFeedback(_ request: URLRequest?, completion: @escaping FeedbackCompletion)
}
