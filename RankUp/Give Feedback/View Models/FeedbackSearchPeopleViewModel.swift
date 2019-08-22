//
//  FeedbackSearchPeopleViewModel.swift
//  RankUp
//
//  Created by Daniel Bernal on 8/20/19.
//

import Foundation

final class FeedbackSearchPeopleViewModel {
    
    var searchResults: [Contact]?
    
    private let apiClient: APIClientFacade
    
    //MARK: - Initializers
    
    init(apiClient: APIClientFacade) {
        self.apiClient = apiClient
    }
    
    
    func fetchRelevantContacts(completion: @escaping () -> Void) {
        apiClient.relevantContacts { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let contacts):
                    self?.searchResults = contacts
                    completion()
                case .failure(let error):
                    print("Les Contacts se fueron a la shit \(error)")
                    completion()
                }
            }
        }
    }
    
    
    func searchPeople(completion: @escaping () -> Void) {
    }
    
    // MARK: - Datasource
    
    func contact(at index: Int) -> Contact? {
        guard let _ = searchResults, index >= 0 && index < searchResults?.count ?? 0 else { return nil }
        return searchResults?[index]
    }


}
