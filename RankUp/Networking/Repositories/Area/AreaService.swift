//
//  AreaService.swift
//  RankUp
//
//  Created by Juan combariza on 7/24/19.
//

import Foundation

typealias RetrieveAreaCompletion = (Result<[Area], RequestError>) -> Void

protocol AreaService {
    func retrieveAreaList(_ request: URLRequest?, completion: @escaping RetrieveAreaCompletion)
}
