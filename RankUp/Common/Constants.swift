//
//  Constants.swift
//  RankUp
//
//  Created by Miguel Rojas on 7/23/19.
//

import Foundation

struct K {
    
    struct Flags {
        static let firstLaunch = "firstLaunch"
    }
    
    struct Storyboards {
        static let onboarding = "Onboarding"
        static let authentication = "Authentication"
        static let feed = "Feed"
        static let giveFeedback = "GiveFeedback"
    }
    
    struct SBIDs {
        static let onboarding = "OnboardingViewController"
    }
    
    struct Segues {
        static let registrationSegue = "registrationSegue"
        static let onboardingSegue = "onboardingSegue"
        static let feedSegue = "feedSegue"
        static let feedbackSegue = "feedbackSegue"
        static let giveFeedbackSegue = "giveFeedbackSegue"
        static let bestsDetailSegue = "bestsDetailSegue"
    }
    
}
