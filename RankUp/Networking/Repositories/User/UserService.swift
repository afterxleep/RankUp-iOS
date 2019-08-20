//
//  UserService.swift
//  RankUp
//
//  Created by Daniel Bernal on 8/20/19.
//

import Foundation

typealias RetrieveUsersCompletion = (Result<[Contact], RequestError>) -> Void

protocol UserService {
    func retrieveUsers(_ request: URLRequest?, completion: @escaping RetrieveUsersCompletion)
}
