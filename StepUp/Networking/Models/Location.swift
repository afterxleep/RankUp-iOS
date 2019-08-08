//
//  Location.swift
//  StepUp
//
//  Created by Juan combariza on 7/24/19.
//

import Foundation

struct Location: Codable {
    var createdAt: Date?
    var updatedAt: Date?
    var id: String?
    var name: String?
    var geolocation: Geolocation?
}

struct Geolocation: Codable {
    var type: String?
    var coordinates: [Double]?
}
