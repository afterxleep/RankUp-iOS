//
//  LoggedInUser.swift
//  StepUp
//
//  Created by Juan combariza on 7/26/19.
//

import Foundation

struct LoggedInUser: Codable {
    var is_registered: Bool?
    var createdAt: Date?
    var updatedAt: Date?
    var id: String?
    var msid: String?
    var name: String?
    var email: String?
    var jobTitle: String?
    var image: String?
    var location: Location?
    var area: Area?
    var rank: Int?
    var score: Int?
    var valuePoints: ValuePoints?
    var role: String?
    var points: Int?
    var bonuses: Int?
    var deductions: Int?
    var feedbacksReceived: Int?
    var feedbacksgiven: Int?
    var lastFeedbackReceived: Int?
    var lastFeedbackGiven: Int?
}

struct ValuePoints: Codable {
    var average: Int?
    var thoughtful: Int
    var open: Int
    var adaptable: Int
    var smart: Int
    var trusted: Int
}
