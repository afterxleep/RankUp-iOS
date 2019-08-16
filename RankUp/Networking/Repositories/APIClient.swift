//
//  APIClientRepository.swift
//  RankUp
//
//  Created by Juan combariza on 7/31/19.
//

import Foundation

class APIClient: APIClientFacade {
    
    private let locationKey = "location"
    private let areaKey = "area"
    private let pageKey = "page"
    private let msidKey = "msid"
    private let commentKey = "comment"
    private let isPublicKey = "isPublic"
    private let isPositiveKey = "isPositive"
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
    
    // MARK: - areas
    
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
    
    // MARK: - locations
    
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
    
    // MARK: - values
    
    func allCompanyValues(completion: @escaping RetrieveCompanyValuesCompletion) {
        msal.retrieveSecurityToken { [weak self] (result) in
            guard let strongSelf = self else {
                completion(.failure(.unableToMakeRequest))
                return
            }
            
            switch result {
            case .success(let token):
                strongSelf.value.retrieveCompanyValues(API.companyValues(token).request(), completion: completion)
            case .failure( _ ):
                completion(.failure(.unableToMakeRequest))
            }
        }
    }
    
    // MARK: - Logged In User
    
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
    
    // MARK: - Feedback
    
    func feedbacks(filter: [String: String]? = nil, completion: @escaping RetrieveFeedbackCompletion) {
        msal.retrieveSecurityToken { [weak self] (result) in
            guard let strongSelf = self else {
                completion(.failure(.unableToMakeRequest))
                return
            }
            
            switch result {
            case .success(let token):
                strongSelf.feedback.retrieveFeedbacks(API.feedback(token).request(parameters: filter), completion: completion)
            case .failure( _ ):
                completion(.failure(.unableToMakeRequest))
            }
        }
    }
    
    func createFeedback(body: CreateFeedbackBody, completion: @escaping FeedbackCompletion) {
        msal.retrieveSecurityToken { [weak self] (result) in
            guard let strongSelf = self else {
                completion(.failure(.unableToMakeRequest))
                return
            }
            
            switch result {
            case .success(let token):
                let body = [strongSelf.msidKey: body.msid,
                            strongSelf.valueKey: body.value,
                            strongSelf.commentKey: body.comment,
                            strongSelf.isPublicKey: "\(body.isPublic)",
                    strongSelf.isPositiveKey: "\(body.isPositive)"]
                
                strongSelf.feedback.createFeedbacks(API.createFeedback(token, body).request(), completion: completion)
            case .failure( _ ):
                completion(.failure(.unableToMakeRequest))
            }
        }
    }
    
    func likeFeedback(feedbackId: String, completion: @escaping FeedbackCompletion) {
        msal.retrieveSecurityToken { [weak self] (result) in
            guard let strongSelf = self else {
                completion(.failure(.unableToMakeRequest))
                return
            }
            
            switch result {
            case .success(let token):
                strongSelf.feedback.likeFeedback(API.likeFeedback(token, feedbackId).request(), completion: completion)
            case .failure( _ ):
                completion(.failure(.unableToMakeRequest))
            }
        }
    }
    
    func flagFeedback(feedbackId: String, completion: @escaping FeedbackCompletion) {
        msal.retrieveSecurityToken { [weak self] (result) in
            guard let strongSelf = self else {
                completion(.failure(.unableToMakeRequest))
                return
            }
            
            switch result {
            case .success(let token):
                strongSelf.feedback.flagFeedback(API.flagFeedback(token, feedbackId).request(), completion: completion)
            case .failure( _ ):
                completion(.failure(.unableToMakeRequest))
            }
        }
    }
    
    // MARK: - Rank
    
    func rankings(filter: RankingFilter, completion: @escaping RetrieveRanksCompletion) {
        msal.retrieveSecurityToken { [weak self] (result) in
            guard let strongSelf = self else {
                completion(.failure(.unableToMakeRequest))
                return
            }
            
            switch result {
            case .success(let token):
                let filter = [strongSelf.pageKey: "\(filter.page)",
                    strongSelf.valueKey: filter.value,
                    strongSelf.locationKey: filter.location,
                    strongSelf.areaKey: filter.area]
                
                strongSelf.rank.retrieveRanks(API.rank(token).request(parameters: filter), completion: completion)
            case .failure( _ ):
                completion(.failure(.unableToMakeRequest))
            }
        }
    }
    
    func profilePhoto(userMSID: String?, completion: @escaping RetrieveProfilePhotoCompletion) {
        msal.retrieveSecurityToken { [weak self] (result) in
            guard let strongSelf = self else {
                completion(.failure(.unableToMakeRequest))
                return
            }
            
            switch result {
            case .success(let token):
                strongSelf.msal.retrieveProfilePhoto(API.profilePhoto(userMSID, token).request(), completion: completion)
            case .failure( _ ):
                completion(.failure(.unableToMakeRequest))
            }
        }
    }
}
