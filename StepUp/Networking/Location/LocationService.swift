//
//  LocationService.swift
//  StepUp
//
//  Created by Juan combariza on 7/24/19.
//

import Foundation

typealias RetrieveLocationCompletion = (Result<[Location], RequestError>) -> Void

protocol LocationService {
    func retrieveLocationList(_ request: URLRequest?, completion: @escaping RetrieveLocationCompletion)
}
