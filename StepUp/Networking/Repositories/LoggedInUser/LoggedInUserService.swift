//
//  LoggedInUserService.swift
//  StepUp
//
//  Created by Juan combariza on 7/26/19.
//

import Foundation

typealias RetrieveLoggedInUserCompletion = (Result<LoggedInUser, RequestError>) -> Void
typealias RetrieveRelevantContactsCompletion = (Result<[Contact], RequestError>) -> Void
typealias UserInformation = (LoggedInUser?,NonResgisterUser?)
typealias RetrieveUserInformationCompletion = (Result<UserInformation, LoggedInUserRequestError>) -> Void

enum LoggedInUserRequestError: Error {
    case unableToMakeRequest
    case requestFailed
    case invalidResponse
    case emptyResponse
    case nonRegisterUser(Data)
}

protocol LoggedInUserService {
    func retrieveUserInformation(_ request: URLRequest?, completion: @escaping RetrieveUserInformationCompletion)
    func registerUser(_ request: URLRequest?, completion: @escaping RetrieveLoggedInUserCompletion)
    func updateUser(_ request: URLRequest?, completion: @escaping RetrieveLoggedInUserCompletion)
    func retrieveRelevantContacts(_ request: URLRequest?, completion: @escaping RetrieveRelevantContactsCompletion)
}
