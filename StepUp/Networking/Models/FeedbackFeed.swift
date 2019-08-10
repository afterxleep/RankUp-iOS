//
//  Feedback.swift
//  StepUp
//
//  Created by Juan combariza on 7/27/19.
//

import Foundation

struct FeedbackFeed: Codable {
    var totalRecords: Int?
    var skip: Int?
    var limit: Int?
    var feedback: [Feedback]?
}

struct Feedback: Codable {
    var createdAt: Date?
    var updatedAt: Date?
    var sortIndex: Int?
    var id: String?
    var from: Contact?
    var to: Contact?
    var value: Value?
    var comment: String?
    var isPublic: Bool?
    var isPinned: Bool?
    var likes: Int?
    var isLikedByUser: Bool?
    var flags: Int?
    var isFlaggedByUser: Bool?
    var isPositive: Bool?
}

struct FeedbackFilter {
    let from: Int
    let to: Int
    let value: String
    let user: String
    let isPrivate: Bool
    let isPinned: Bool
    let skip: Int
    let limit: Int
}
