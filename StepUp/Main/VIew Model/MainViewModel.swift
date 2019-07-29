//
//  MainViewModel.swift
//  StepUp
//
//  Created by Miguel Rojas on 7/28/19.
//

import Foundation

struct MainViewModel {
    
    // MARK: - Interface
    
    var initialStoryboard: String {
        let isFirstLaunch = UserDefaults.standard.bool(forKey: K.Flags.firstLaunch)
        
        return isFirstLaunch ? K.Storyboards.feed : K.Storyboards.authentication 
    }
    
}
