//
//  API.swift
//  StepUp
//
//  Created by Juan combariza on 7/26/19.
//

import Foundation

typealias SecureToken = String
typealias HttpBody = [String: String]
typealias UrlParameters = [String: String]

enum API: Parseable {
    case area(SecureToken)
    case location(SecureToken)
    case loggedInUser(SecureToken)
    case registerUser(SecureToken, HttpBody)
    case updateUser(SecureToken, HttpBody)
    case companyValues(SecureToken)
    case contacts(SecureToken)
    case feedback(SecureToken)
    case createFeedback(SecureToken, HttpBody)
    case rank(SecureToken)
    
    //MARK: - constants
    
    private static let authorizationKey             = "Authorization"
    private static let authorizationValeFormat      = "Bearer %@"
    private static let scheme                       = "https"
    private static let contentTypeKey               = "Content-Type"
    private static let contentTypeValue             = "application/json; charset=utf-8"
    private static let TestHost                     = "rankme-test.herokuapp.com"
    private static let ProdHost                     = "rankme-prod.herokuapp.com"
    private static let host                         = SystemUtils.isDebug ? TestHost : ProdHost
    
    
    //MARK: - get request
    
    func request(parameters: UrlParameters? = nil) -> URLRequest? {
        guard let url = createUrl(with: parameters) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        
        switch self {
        case .area(let token),
             .location(let token),
             .loggedInUser(let token),
             .companyValues(let token),
             .contacts(let token),
             .feedback(let token),
             .rank(let token):
            request.httpMethod = HTTPMethod.get.rawValue
            request.allHTTPHeaderFields = createHeader(token: token)
        case .registerUser(let token, let body), .createFeedback(let token, let body):
            request.httpMethod = HTTPMethod.post.rawValue
            request.allHTTPHeaderFields = createHeader(token: token)
            request.httpBody = createBody(parameters: body)
        case .updateUser(let token, let body):
            request.httpMethod = HTTPMethod.put.rawValue
            request.allHTTPHeaderFields = createHeader(token: token)
            request.httpBody = createBody(parameters: body)
        }
        
        return request
    }
    
    static func parser<T: Codable>(from data: Data, to: T.Type) -> T? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        
        guard let response = try? decoder.decode(T.self, from: data) else {
            return nil
        }
        
        return response
    }
    
    //MARK: - Auxiliary variables
    
    private var endPoint: String {
        switch self {
        case .area(_):
            return "/area"
        case .location(_):
            return "/location"
        case .loggedInUser(_), .updateUser(_), .registerUser(_):
            return "/me"
        case .companyValues(_):
            return "/value"
        case .contacts(_):
            return "/people/relevant-contacts"
        case .feedback(_), .createFeedback(_):
            return "/feedback"
        case .rank(_):
            return "/ranking"
        }
    }
    
    //MARK: - Auxiliary methods
    
    private func createUrl(with parameters: UrlParameters?) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = API.scheme
        urlComponents.host = API.host
        urlComponents.path = endPoint
        urlComponents.queryItems = queryItems(dictionary: parameters)
        
        return urlComponents.url
    }
    
    private func queryItems(dictionary: UrlParameters?) -> [URLQueryItem]? {
        guard let dictionary = dictionary else { return nil }
        
        return dictionary.map {
            URLQueryItem(name: $0.0, value: $0.1)
        }
    }
    
    private func createHeader(token: String) -> [String: String] {
        return [API.authorizationKey: String(format: API.authorizationValeFormat, token),
                API.contentTypeKey: API.contentTypeValue]
    }
    
    private func createBody(parameters: [String: String]) -> Data? {
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return nil
        }
        
        return httpBody
    }
}

protocol Parseable {
    static func parser<T: Codable>(from data: Data, to: T.Type) -> T?
}
