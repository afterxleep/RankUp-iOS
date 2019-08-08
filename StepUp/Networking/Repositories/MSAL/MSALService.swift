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
    var delegate: MSALDelegate? { get set }
    
    func retrieveSecurityToken(completion: @escaping RetrieveTokenCompletion)
    func logOutUser()
}
