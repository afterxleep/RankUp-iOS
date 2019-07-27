//
//  Location.swift
//  StepUp
//
//  Created by Juan combariza on 7/24/19.
//

import Foundation

struct Location: Codable {
    let createdAt: Date
    let updatedAt: Date
    let id: String
    let name: String
    let geolocation: Geolocation
}

struct Geolocation: Codable {
    let type: String
    let coordinates: [Double]
}
