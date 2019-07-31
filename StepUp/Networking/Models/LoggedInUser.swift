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
    let location: Location
    let area: Area
    let rank: Int
    let score: Int
    let valueScore: ValuePoints
    let role: String
//    let points: Int
//    let bonuses: Int
//    let deductions: Int
//    let feedbacksReceived: Int
//    let feedbacksgiven: Int
//    let lastFeedbackReceived: Int
//    let lastFeedbackGiven: Int
}

struct ValuePoints: Codable {
    let average: Int
    let thoughtful: Int
    let open: Int
    let adaptable: Int
    let smart: Int
    let trusted: Int
}
