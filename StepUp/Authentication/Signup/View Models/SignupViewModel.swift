//
//  SignupViewModel.swift
//  StepUp
//
//  Created by Miguel Rojas on 7/28/19.
//

import Foundation

final class SignupViewModel {
    
    // MARK: - Stored Properties
    
    private let apiClient: APIClientService
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
    
    init(apiClient: APIClientService) {
        self.apiClient = apiClient
    }
    
    // MARK: - Inteface
    
    func registerUser(location: String, area: String, completion: @escaping () -> Void) {
        apiClient.registerUser(location: location, area: area) { (result) in
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
    
    // Registers the User in the StepUP database or updates the access token
    //    func fetchProfile() {
    //        DispatchQueue.main.async{
    //            self.statusLabel.text = "Syncing Stats"
    //        }
    //
    //
    //        let params = ["from": "1563757462558",
    //                      "to": "1663757462558",
    //                      "page":"1",
    //                      "value":"12345678",
    //                      "user": "5d37ee0b68f99c7a7d5779f6",
    //                      "private": "true",
    //                      "pinned":"false"]
    //
    //        FeedbackRepository().retrieveFeedbacks(API.feedback(self.accessToken).request(parameters: params)) { (result) in
    //            switch result {
    //            case .success(let feedback):
    //                print("\(feedback)")
    //            case .failure(let error):
    //                print(error)
    //            }
    //        }
    //
    //        URLSession.shared.dataTask(with: request) { data, response, error in
    //            if let error = error {
    //                print("Couldn't get API result: \(error)")
    //                return
    //            }
    //            guard let result = try? JSONSerialization.jsonObject(with: data!, options: []) else {
    //                print("Couldn't deserialize result JSON")
    //                return
    //            }
    //            print("Result from API: \(result))")
    //            DispatchQueue.main.async{
    //                self.statusLabel.text = "Ready!"
    //            }
    //            }.resume()
    //    }
    
}
