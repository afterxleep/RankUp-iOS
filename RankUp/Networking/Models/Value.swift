//
//  Value.swift
//  RankUp
//
//  Created by Juan combariza on 7/27/19.
//

import Foundation

struct Value: Codable {
    var createdAt: Date
    var updatedAt: Date
    var id: String
    var name: String
    var description: String
    var image: String?
}
