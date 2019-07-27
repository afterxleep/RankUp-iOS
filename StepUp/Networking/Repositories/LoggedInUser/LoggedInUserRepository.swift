//
//  LoggedInUserRepository.swift
//  StepUp
//
//  Created by Juan combariza on 7/26/19.
//

import Foundation

struct LoggedInUserRepository: LoggedInUserService {

    //MARK: - Logged In User request
    
    func retrieveLoggedInUser(_ request: URLRequest?, completion: @escaping RetrieveLoggedInUserCompletion) {
        commonRequest(request, completion: completion)
    }
    
    //MARK: - create local Logged In User request
    
    func createNewLocalUser(_ request: URLRequest?, completion: @escaping RetrieveLoggedInUserCompletion) {
        commonRequest(request, completion: completion)
    }
    
    //MARK: - update local Logged In User request
    
    func updateLocalUser(_ request: URLRequest?, completion: @escaping RetrieveLoggedInUserCompletion) {
        commonRequest(request, completion: completion)
    }
    
    //MARK: - auxiliary methods
    
    private func commonRequest(_ request: URLRequest?, completion: @escaping RetrieveLoggedInUserCompletion) {
        guard let request = request else {
            completion(.failure(.unableToMakeRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            switch BasicRequest.handleBasicResponse(with: data, response: response, error: error) {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                guard let model = API.parser(from: data, to: LoggedInUser.self) else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                completion(.success(model))
            }
        })
        
        task.resume()
    }
}
