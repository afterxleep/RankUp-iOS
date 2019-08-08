//
//  APIClientRepository.swift
//  StepUp
//
//  Created by Juan combariza on 7/31/19.
//

import Foundation

class APIClient: APIClientFacade {
    
    private let locationKey = "location"
    private let areaKey = "area"
    private let pageKey = "page"
    private let valueKey = "value"
    
    private lazy var area: AreaService = { return AreaRepository() }()
    private lazy var location: LocationService = { return LocationRepository() }()
    private lazy var msal: MSALService = { return MSALRepository() }()
    private lazy var loggedInUser: LoggedInUserService = { return LoggedInUserRepository() }()
    private lazy var value: CompanyValuesService = { return CompanyValuesRepository() }()
    private lazy var feedback: FeedbackService = { return FeedbackRepository() }()
    private lazy var rank: RankService = { return RankRepository() }()
    
    weak var msalDelegate: MSALDelegate? {
        didSet {
            msal.delegate = msalDelegate
        }
    }

    func allCompanyAreas(completion: @escaping RetrieveAreaCompletion) {
        msal.retrieveSecurityToken { [weak self] (result) in
            guard let strongSelf = self else {
                completion(.failure(.unableToMakeRequest))
                return
            }
            
            switch result {
            case .success(let token):
                strongSelf.area.retrieveAreaList(API.area(token).request(), completion: completion)
            case .failure( _ ):
                completion(.failure(.unableToMakeRequest))
            }
        }
    }
    
    func allCompanyLocations(completion: @escaping RetrieveLocationCompletion) {
        msal.retrieveSecurityToken { [weak self] (result) in
            guard let strongSelf = self else {
                completion(.failure(.unableToMakeRequest))
                return
            }
            
            switch result {
            case .success(let token):
                strongSelf.location.retrieveLocationList(API.location(token).request(), completion: completion)
            case .failure( _ ):
                completion(.failure(.unableToMakeRequest))
            }
        }
    }
    
    func userInformation(completion: @escaping RetrieveUserInformationCompletion) {
        msal.retrieveSecurityToken { [weak self] (result) in
            guard let strongSelf = self else {
                completion(.failure(.unableToMakeRequest))
                return
            }
            
            switch result {
            case .success(let token):
                strongSelf.loggedInUser.retrieveUserInformation(API.loggedInUser(token).request(), completion: completion)
            case .failure( _ ):
                completion(.failure(.unableToMakeRequest))
            }
        }
    }
    
    func registerUser(location: String, area: String, completion: @escaping RetrieveLoggedInUserCompletion) {
        msal.retrieveSecurityToken { [weak self] (result) in
            guard let strongSelf = self else {
                completion(.failure(.unableToMakeRequest))
                return
            }
            
            switch result {
            case .success(let token):
                let body = [strongSelf.locationKey: location,
                            strongSelf.areaKey: area]
                
                strongSelf.loggedInUser.registerUser(API.registerUser(token, body).request(), completion: completion)
            case .failure( _ ):
                completion(.failure(.unableToMakeRequest))
            }
        }
    }
    
    func updateUser(location: String, area: String, completion: @escaping RetrieveLoggedInUserCompletion) {
        msal.retrieveSecurityToken { [weak self] (result) in
            guard let strongSelf = self else {
                completion(.failure(.unableToMakeRequest))
                return
            }
            
            switch result {
            case .success(let token):
                let body = [strongSelf.locationKey: location,
                            strongSelf.areaKey: area]
                
                strongSelf.loggedInUser.updateUser(API.updateUser(token, body).request(), completion: completion)
            case .failure( _ ):
                completion(.failure(.unableToMakeRequest))
            }
        }
    }
    
    func relevantContacts(completion: @escaping RetrieveRelevantContactsCompletion) {
        msal.retrieveSecurityToken { [weak self] (result) in
            guard let strongSelf = self else {
                completion(.failure(.unableToMakeRequest))
                return
            }
            
            switch result {
            case .success(let token):
                strongSelf.loggedInUser.retrieveRelevantContacts(API.contacts(token).request(), completion: completion)
            case .failure( _ ):
                completion(.failure(.unableToMakeRequest))
            }
        }
    }
    
    func rankings(page: String, value: String, location: String, area: String, completion: @escaping RetrieveRanksCompletion) {
        msal.retrieveSecurityToken { [weak self] (result) in
            guard let strongSelf = self else {
                completion(.failure(.unableToMakeRequest))
                return
            }
            
            switch result {
            case .success(let token):
                let filter = [strongSelf.pageKey: page,
                              strongSelf.valueKey: value,
                              strongSelf.locationKey: location,
                              strongSelf.areaKey: area]
                
                strongSelf.rank.retrieveRanks(API.rank(token).request(parameters: filter), completion: completion)
            case .failure( _ ):
                completion(.failure(.unableToMakeRequest))
            }
        }
    }
}
