//
//  FeedbackService.swift
//  StepUp
//
//  Created by Juan combariza on 7/27/19.
//

import Foundation

typealias RetrieveFeedbackCompletion = (Result<FeedbackFeed, RequestError>) -> Void

protocol FeedbackService {
    func retrieveFeedbacks(_ request: URLRequest?, completion: @escaping RetrieveFeedbackCompletion)
}
