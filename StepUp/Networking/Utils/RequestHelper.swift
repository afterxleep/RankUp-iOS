//
//  Result.swift
//  StepUp
//
//  Created by Juan combariza on 7/24/19.
//

import Foundation

enum Result<T, Error: Swift.Error> {
    case success(T)
    case failure(Error)
}

enum RequestError: Error {
    case unableToMakeRequest
    case requestFailed
    case invalidResponse
    case emptyResponse
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

struct BasicRequest {
    static func handleBasicResponse(with data: Data?, response: URLResponse?, error: Error?) -> Result<Data, RequestError> {
        if let _ = error {
            return .failure(RequestError.requestFailed)
        }
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            return .failure(.requestFailed)
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
