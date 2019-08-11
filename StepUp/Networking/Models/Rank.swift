//
//  Rank.swift
//  StepUp
//
//  Created by Juan combariza on 7/30/19.
//

import Foundation

struct Rank: Codable {
    var id: String?
    var msid: String?
    var name: String?
    var jobTitle: String?
    var email: String?
    var image: String?
    var rank: Int?
    var score: Int?
}

struct RankingFilter {
    let page: Int
    let value: String
    let location: String
    let area: String
}
