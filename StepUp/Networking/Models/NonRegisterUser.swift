//
//  NonRegisterUser.swift
//  StepUp
//
//  Created by Juan combariza on 7/30/19.
//

import Foundation

struct NonResgisterUser: Codable {
    let code: Int
    let error: String
    let data: UserModel
}

struct UserModel: Codable {
    let user: User
}

struct User: Codable {
    let msid: String
    let name: String
    let jobTitle: String
    let email: String
    let image: String
}
