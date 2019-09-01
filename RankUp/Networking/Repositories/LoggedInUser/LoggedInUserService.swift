//
//  LoggedInUserService.swift
//  RankUp
//
//  Created by Juan combariza on 7/26/19.
//

import Foundation

typealias RetrieveLoggedInUserCompletion = (Result<LoggedInUser, RequestError>) -> Void
typealias RetrieveRelevantContactsCompletion = (Result<[Contact], RequestError>) -> Void
typealias UserInformation = (LoggedInUser?,UnregisteredUser?)
typealias RetrieveUserInformationCompletion = (Result<UserInformation, RequestError>) -> Void

protocol LoggedInUserService {
    func retrieveUserInformation(_ request: URLRequest?, completion: @escaping RetrieveUserInformationCompletion)
    func registerUser(_ request: URLRequest?, completion: @escaping RetrieveLoggedInUserCompletion)
    func updateUser(_ request: URLRequest?, completion: @escaping RetrieveLoggedInUserCompletion)
    func retrieveRelevantContacts(_ request: URLRequest?, completion: @escaping RetrieveRelevantContactsCompletion)
}
