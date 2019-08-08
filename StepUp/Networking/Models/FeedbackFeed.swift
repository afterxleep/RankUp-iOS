//
//  Feedback.swift
//  StepUp
//
//  Created by Juan combariza on 7/27/19.
//

import Foundation

struct FeedbackFeed: Codable {
    let totalRecords: Int
    let skip: Int
    let limit: Int
    let feedback: [Feedback]
}

struct Feedback: Codable {
    let createdAt: Date
    let updatedAt: Date
    let sortIndex: Int
    let id: String
    let from: Contact
    let to: Contact
    let value: Value
    let comment: String
    let isPublic: Bool
    let isPinned: Bool
    let likes: Int
    let isLikedByUser: Bool
    let flags: Int
    let isFlaggedByUser: Bool
    let isPositive: Bool
}
