//
//  MSALDelegate.swift
//  RankUp
//
//  Created by Juan combariza on 7/31/19.
//

import Foundation

protocol MSALDelegate: AnyObject {
    func initializing(_ repository: MSALRepository)
    func authenticating(_ repository: MSALRepository)
    func accessTokenDidAcquired(_ repository: MSALRepository)
}
