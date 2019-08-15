//
//  LoggedInUser.swift
//  RankUp
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
    var valuePoints: [String: Int]?
    var role: String?
    var points: Int?
    var bonuses: Int?
    var deductions: Int?
    var feedbacksReceived: Int?
    var feedbacksGiven: Int?
    var lastFeedbackReceived: Int?
    var lastFeedbackGiven: Int?
}
