//
//  MSALService.swift
//  StepUp
//
//  Created by Juan combariza on 7/31/19.
//

import Foundation
import MSAL

typealias RetrieveTokenCompletion = (Result<String, MsalApiError>) -> Void

enum MsalApiError: Error {
    case unableToInitializeMSAL
    case unableToCreateAuthorityURL
    case unableToAcquireToken
}

protocol MSALService: AnyObject {
    func retrieveSecurityToken(completion: @escaping RetrieveTokenCompletion)
    func logOutUser()
}
