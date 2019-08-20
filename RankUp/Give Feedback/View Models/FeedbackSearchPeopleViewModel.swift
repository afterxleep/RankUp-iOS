//
//  FeedbackSearchPeopleViewModel.swift
//  RankUp
//
//  Created by Daniel Bernal on 8/20/19.
//

import Foundation

struct FeedbackSearchPeopleViewModel {
    
    var searchResults: [Contact]?
    private let apiClient: APIClientFacade
    
    //MARK: - Initializers
    
    init(apiClient: APIClientFacade) {
        self.apiClient = apiClient
    }
    
    
    func fetchRelevantPeople(completion: @escaping () -> Void) {
    }
    
    func searchPeople(completion: @escaping () -> Void) {
        
    }

}
