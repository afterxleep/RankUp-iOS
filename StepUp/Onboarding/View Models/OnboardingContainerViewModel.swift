//
//  OnboardingContainerViewModel.swift
//  Travelers
//
//  Created by Miguel Rojas on 28/07/18.
//

import Foundation

enum ControllerDirection {
    case before
    case after
    case idle
}

struct OnboardingContainerViewModel {
    
    let onboardingModel: [OnboardingViewModel] = {
        
        return [OnboardingViewModel(imageName: "onBoarding3",
                                    title: "Closer Feedback",
                                    description: "Get closer to feedback cycle. Make honest, trusted and accurate feedback"),
                OnboardingViewModel(imageName: "onBoarding1",
                                    title: "Rank Me",
                                    description: "Interact with others and be the best you can be"),
                OnboardingViewModel(imageName: "onBoarding2",
                                    title: "Recognize",
                                    description: "Recognize those who deserve it by giving a punctuation based on our core values")]
    }()
    
    var modelsCount: Int {
        return onboardingModel.count
    }
    
    func modelForIndex(index: Int?, direction: ControllerDirection = .idle) -> OnboardingViewModel? {
        guard var index = index else { return nil }
        index = direction == .before ? index - 1 : direction == .after ? index + 1 : index
        guard 0 ... onboardingModel.count - 1  ~= index else { return nil }
        
        return onboardingModel[index]
    }
    
    func indexForModel(model: OnboardingViewModel?) -> Int? {
        return onboardingModel.firstIndex { $0.imageName == model?.imageName && $0.title == model?.title && $0.description == model?.description}
    }
    
}
