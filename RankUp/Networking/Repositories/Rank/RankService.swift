//
//  RankService.swift
//  RankUp
//
//  Created by Juan combariza on 7/30/19.
//

import Foundation

typealias RetrieveRanksCompletion = (Result<[Rank], RequestError>) -> Void

protocol RankService {
    func retrieveRanks(_ request: URLRequest?, completion: @escaping RetrieveRanksCompletion)
}
