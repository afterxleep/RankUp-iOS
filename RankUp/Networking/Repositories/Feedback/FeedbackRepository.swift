//
//  FeedbackRepository.swift
//  RankUp
//
//  Created by Juan combariza on 7/27/19.
//

import Foundation

struct FeedbackRepository: FeedbackService {
    
    //MARK: - Get all feedbacks request

    func retrieveFeedbacks(_ request: URLRequest?, completion: @escaping RetrieveFeedbackCompletion) {
        guard let request = request else {
            completion(.failure(.unableToMakeRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            switch BasicRequest.handleBasicResponse(with: data, response: response, error: error) {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                guard let model = API.parser(from: data, to: FeedbackFeed.self) else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                completion(.success(model))
            }
        })
        
        task.resume()
    }
    
    //MARK: - Create feedback request
    
    func createFeedbacks(_ request: URLRequest?, completion: @escaping FeedbackCompletion) {
        commoRequest(request, completion: completion)
    }
    
    // MARK: - like feedback
    
    func likeFeedback(_ request: URLRequest?, completion: @escaping FeedbackCompletion) {
        commoRequest(request, completion: completion)
    }
    
    // MARK: - flag feedback
    
    func flagFeedback(_ request: URLRequest?, completion: @escaping FeedbackCompletion) {
        commoRequest(request, completion: completion)
    }
    
    // MARK: - Auxiliary method
    
    private func commoRequest(_ request: URLRequest?, completion: @escaping FeedbackCompletion) {
        guard let request = request else {
            completion(.failure(.unableToMakeRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            switch BasicRequest.handleBasicResponse(with: data, response: response, error: error) {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                guard let model = API.parser(from: data, to: Feedback.self) else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                completion(.success(model))
            }
        })
        
        task.resume()
    }
    
}
