//
//  Feedback.swift
//  StepUp
//
//  Created by Juan combariza on 7/27/19.
//

import Foundation

struct FeedbackFeed: Codable {
    let total_records: Int
    let page: Int
    let total_pages: Int
    let feedback: [Feedback]
}

struct Feedback: Codable {
    let createdAt: Date
    let updatedAt: Date
    let id: String
    let from: Contact
    let to: Contact
    let value: Value
    let comment: String
    let is_public: Bool
    let is_pinned: Bool
    let pushes: Int
    let pushes_by_user: Bool
}
