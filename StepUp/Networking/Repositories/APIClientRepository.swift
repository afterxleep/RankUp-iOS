//
//  APIClientRepository.swift
//  StepUp
//
//  Created by Juan combariza on 7/31/19.
//

import Foundation

class APIClientRepository: APIClientService {
    
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
        area.retrieveAreaList(API.area("token").request(), completion: completion)
    }
    
    func allCompanyLocations(completion: @escaping RetrieveLocationCompletion) {
        location.retrieveLocationList(API.location("token").request(), completion: completion)
    }
    
    func userInformation(completion: @escaping RetrieveUserInformationCompletion) {
        loggedInUser.retrieveUserInformation(API.loggedInUser("token").request(), completion: completion)
    }
    
    func registerUser(location: String, area: String, completion: @escaping RetrieveLoggedInUserCompletion) {
        let body = [locationKey: location,
                    areaKey: area]
        
        loggedInUser.registerUser(API.registerUser("token", body).request(), completion: completion)
    }
    
    func updateUser(location: String, area: String, completion: @escaping RetrieveLoggedInUserCompletion) {
        let body = [locationKey: location,
                    areaKey: area]
        
        loggedInUser.updateUser(API.updateUser("token", body).request(), completion: completion)
    }
    
    func relevantContacts(completion: @escaping RetrieveRelevantContactsCompletion) {
        loggedInUser.retrieveRelevantContacts(API.contacts("token").request(), completion: completion)
    }
    
    func rankings(page: String, value: String, location: String, area: String, completion: @escaping RetrieveRanksCompletion) {
        let filter = [pageKey: page,
                      valueKey: value,
                      locationKey: location,
                      areaKey: area]
        
        rank.retrieveRanks(API.rank("token").request(parameters: filter), completion: completion)
    }
    
    func securityToken(completion: @escaping RetrieveTokenCompletion) {
        msal.retrieveSecurityToken(completion: completion)
    }
}
