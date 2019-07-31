//
//  LoggedInUserRepository.swift
//  StepUp
//
//  Created by Juan combariza on 7/26/19.
//

import Foundation

struct LoggedInUserRepository: LoggedInUserService {
    
    //MARK: - Logged In User request
    
    func retrieveUserInformation(_ request: URLRequest?, completion: @escaping RetrieveUserInformationCompletion) {
        guard let request = request else {
            completion(.failure(.unableToMakeRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            switch self.handleBasicResponse(with: data, response: response, error: error) {
            case .failure(let error):
                switch error {
                case .nonRegisterUser(let data):
                    guard let model = API.parser(from: data, to: NonResgisterUser.self) else {
                        completion(.failure(.invalidResponse))
                        return
                    }
                    
                    completion(.success((nil,model)))
                default:
                  completion(.failure(error))
                }
            case .success(let data):
                guard let model = API.parser(from: data, to: LoggedInUser.self) else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                completion(.success((model,nil)))
            }
        })
        
        task.resume()
    }
    
    //MARK: - create local Logged In User request
    
    func registerUser(_ request: URLRequest?, completion: @escaping RetrieveLoggedInUserCompletion) {
        commonRequest(request, completion: completion)
    }
    
    //MARK: - update local Logged In User request
    
    func updateUser(_ request: URLRequest?, completion: @escaping RetrieveLoggedInUserCompletion) {
        commonRequest(request, completion: completion)
    }
    
    //MARK: - Get relevant contacts request
    
    func retrieveRelevantContacts(_ request: URLRequest?, completion: @escaping RetrieveRelevantContactsCompletion) {
        guard let request = request else {
            completion(.failure(.unableToMakeRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            switch BasicRequest.handleBasicResponse(with: data, response: response, error: error) {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                guard let model = API.parser(from: data, to: [Contact].self) else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                completion(.success(model))
            }
        })
        
        task.resume()
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
    
    private func handleBasicResponse(with data: Data?, response: URLResponse?, error: Error?) -> Result<Data, LoggedInUserRequestError> {
        if let _ = error {
            return .failure(.requestFailed)
        }
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            return .failure(.requestFailed)
        }
        
        if statusCode == 404 {
            guard let data = data else {
                return .failure(.emptyResponse)
            }
            
            return .failure(.nonRegisterUser(data))
        }
        
        guard (200...299).contains(statusCode) else {
            return .failure(.requestFailed)
        }
        
        guard let data = data else {
            return .failure(.emptyResponse)
        }
        
        return .success(data)
    }
}
