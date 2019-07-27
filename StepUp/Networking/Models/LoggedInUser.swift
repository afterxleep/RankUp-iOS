//
//  LoggedInUser.swift
//  StepUp
//
//  Created by Juan combariza on 7/26/19.
//

import Foundation

struct LoggedInUser: Codable {
    let is_registered: Bool
    let createdAt: Date
    let updatedAt: Date
    let id: String
    let msid: String
    let name: String
    let email: String
    let jobTitle: String
    let image: String
    let rank: Int
    let scores: Scores
    let role: String
    let location: Location
    let area: Area
}

struct Scores: Codable {
    let average: Int
    let thoughtful: Int
    let open: Int
    let adaptable: Int
    let smart: Int
    let trusted: Int
}
