//
//  SignupViewModel.swift
//  StepUp
//
//  Created by Miguel Rojas on 7/28/19.
//

import Foundation

final class SignupViewModel {
    
    // MARK: - Stored Properties
    
    private let apiClient: APIClientFacade
    private var disciplines = [Area]()
    private var locations = [Location]()
    
    var userModel: UnregisteredUser?
    
    // MARK: - Computed Properties
    
    var numberOfDisciplineItems: Int {
        return disciplines.count
    }
    
    var numberOfLocatonItems: Int {
        return locations.count
    }
    
    // MARK: - Initializers
    
    init(apiClient: APIClientFacade) {
        self.apiClient = apiClient
    }
    
    // MARK: - Inteface
    
    func registerUser(location: String?, discipline: String?, completion: @escaping () -> Void) {
        guard
            let locationID = locations.first(where: { $0.name == location })?.id,
            let disciplineID = disciplines.first(where: { $0.name == discipline })?.id
            else { return }
        
        apiClient.registerUser(location: locationID, area: disciplineID) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let createdLoggedInUser):
                    print("\(createdLoggedInUser)")
                case .failure(let error):
                    print(error)
                }
                
                completion()
            }
        }
    }
    
    func fetchLocationDisciplinesData(completion: @escaping (Error?) -> Void) {        
        let dispatchGroup = DispatchGroup()
        var requestError: RequestError?
        
        dispatchGroup.enter()
        apiClient.allCompanyAreas { [weak self] result in
            dispatchGroup.leave()
            switch result {
            case .success(let areas):
                self?.disciplines = areas
            case .failure(let error):
                requestError = error
            }
        }
        
        dispatchGroup.enter()
        apiClient.allCompanyLocations { [weak self] result in
            dispatchGroup.leave()
            switch result {
            case .success(let locations):
                self?.locations = locations
            case .failure(let error):
                requestError = error
            }
        }
        
        dispatchGroup.notify(qos: .userInitiated, queue: DispatchQueue.main) {
            completion(requestError)
        }
    }
    
    func location(at row: Int) -> String? {
        guard row >= 0 && row <= locations.count - 1 else { return nil }
        return locations[row].name
    }
    
    func discipline(at row: Int) -> String? {
        guard row >= 0 && row <= disciplines.count - 1 else { return nil }
        return disciplines[row].name
    }
    
}
