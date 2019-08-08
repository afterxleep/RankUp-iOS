//
//  APIClientService.swift
//  StepUp
//
//  Created by Juan combariza on 7/31/19.
//

import Foundation

protocol APIClientService: AnyObject {
    func allCompanyAreas(completion: @escaping RetrieveAreaCompletion)
    func allCompanyLocations(completion: @escaping RetrieveLocationCompletion)
    func userInformation(completion: @escaping RetrieveUserInformationCompletion)
    func registerUser(location: String, area: String, completion: @escaping RetrieveLoggedInUserCompletion)
    func updateUser(location: String, area: String, completion: @escaping RetrieveLoggedInUserCompletion)
    func relevantContacts(completion: @escaping RetrieveRelevantContactsCompletion)
    
    func rankings(page: String, value: String, location: String, area: String, completion: @escaping RetrieveRanksCompletion)
}
