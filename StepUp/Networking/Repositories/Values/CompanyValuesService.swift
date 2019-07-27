//
//  ValuesService.swift
//  StepUp
//
//  Created by Juan combariza on 7/27/19.
//

import Foundation

typealias RetrieveCompanyValuesCompletion = (Result<Value, RequestError>) -> Void

protocol CompanyValuesService {
    func retrieveCompanyValues(_ request: URLRequest?, completion: @escaping RetrieveCompanyValuesCompletion)
}
