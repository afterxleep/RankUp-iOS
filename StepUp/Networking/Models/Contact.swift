//
//  Contact.swift
//  StepUp
//
//  Created by Juan combariza on 7/27/19.
//

import Foundation

struct Contact: Codable {
    var createdAt: Date?
    var updatedAt: Date?
    var id: String?
    var msid: String?
    var name: String?
    var email: String?
    var jobTitle: String?
    var image: String?
    var rank: Int?
    var valuePoints: [String: Int]?
    var role: String?
    var is_registered: Bool?
    var location: String?
    var area: String?
}
