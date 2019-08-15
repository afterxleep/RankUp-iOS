//
//  AreaRepository.swift
//  RankUp
//
//  Created by Juan combariza on 7/24/19.
//

import Foundation

struct AreaRepository: AreaService {
    
    //MARK: - Area request
    
    func retrieveAreaList(_ request: URLRequest?, completion: @escaping RetrieveAreaCompletion) {
        guard let request = request else {
            completion(.failure(.unableToMakeRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            switch BasicRequest.handleBasicResponse(with: data, response: response, error: error) {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                guard let model = API.parser(from: data, to: [Area].self) else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                completion(.success(model))
            }
        })
        
        task.resume()
    }
}
