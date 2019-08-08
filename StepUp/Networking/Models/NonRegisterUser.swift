//
//  UnregisteredUser.swift
//  StepUp
//
//  Created by Juan combariza on 7/30/19.
//

import Foundation

struct UnregisteredUser: Codable {
    var code: Int?
    var error: String?
    var data: UserModel?
}

struct UserModel: Codable {
    var user: User?
}

struct User: Codable {
    var msid: String?
    var name: String?
    var jobTitle: String?
    var email: String?
    var image: String?
}
