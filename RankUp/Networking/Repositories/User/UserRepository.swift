//
//  UserRepository.swift
//  RankUp
//
//  Created by Daniel Bernal on 8/20/19.
//

import Foundation

struct UserRepository: UserService {
    
    //MARK: - User Request
    func retrieveUsers(_ request: URLRequest?, completion: @escaping RetrieveUsersCompletion) {
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
}
