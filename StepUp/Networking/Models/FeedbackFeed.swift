//
//  Feedback.swift
//  StepUp
//
//  Created by Juan combariza on 7/27/19.
//

import Foundation

struct FeedbackFilterKeys {
    static let valueKey = "value"
    static let fromKey = "from"
    static let toKey = "to"
    static let userKey = "user"
    static let isPrivateKey = "isPrivate"
    static let isPinnedKey = "isPinned"
    static let skipKey = "skip"
    static let limitKey = "limit"
}

struct FeedbackFeed: Codable {
    var totalRecords: Int?
    var skipped: Int?
    var limit: Int?
    var feedbacks: [Feedback]?
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
    var isLikedByuser: Bool?
    var flags: Int?
    var isFlaggedByuser: Bool?
    var isPositive: Bool?
}

struct CreateFeedbackBody {
    let msid: String
    let value: String
    let comment: String
    let isPublic: Bool
    let isPositive: Bool
}
