//
//  FeedbackModel.swift
//  RankUp
//
//  Created by Miguel D Rojas Cortés on 8/18/19.
//

import Foundation

struct FeedbackModel {
    var userMSID: String
    var userName: String
    var userRank = String()
    
    init(withMSID msid: String, andName name: String) {
        self.userMSID = msid
        self.userName = name
    }

}
