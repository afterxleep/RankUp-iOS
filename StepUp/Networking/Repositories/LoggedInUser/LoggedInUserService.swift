//
//  LoggedInUserService.swift
//  StepUp
//
//  Created by Juan combariza on 7/26/19.
//

import Foundation

typealias RetrieveLoggedInUserCompletion = (Result<LoggedInUser, RequestError>) -> Void
typealias RetrieveRelevantContactsCompletion = (Result<[Contact], RequestError>) -> Void

protocol LoggedInUserService {
    func retrieveLoggedInUser(_ request: URLRequest?, completion: @escaping RetrieveLoggedInUserCompletion)
    func createNewLocalUser(_ request: URLRequest?, completion: @escaping RetrieveLoggedInUserCompletion)
    func updateLocalUser(_ request: URLRequest?, completion: @escaping RetrieveLoggedInUserCompletion)
    func retrieveRelevantContacts(_ request: URLRequest?, completion: @escaping RetrieveRelevantContactsCompletion)
}
