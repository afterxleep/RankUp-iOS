//
//  OnboardingContainerViewModel.swift
//  Travelers
//
//  Created by Miguel Rojas on 28/07/18.
//

import UIKit

enum ControllerDirection {
    case before
    case after
    case idle
}

struct OnboardingContainerViewModel {

    // MARK: - Interface
    
    let onboardingModel: [OnboardingModel] = {
        let firstLineAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.dark]
        let firstOnboardingTitle = UIHelper.createAttributedTitle(firstWord: "Closer\n", secondWord: "FeedBack", firstLineAttrs: firstLineAttributes)
        let secondOnboardingTitle = UIHelper.createAttributedTitle(firstWord: "Recognize\n", secondWord: "your peers", firstLineAttrs: firstLineAttributes)
        let thirdOnboardingTitle = UIHelper.createAttributedTitle(firstWord: "Rank", secondWord: "Up", firstLineAttrs: firstLineAttributes)
        
        return [OnboardingModel(imageName: "feedback",
                                title: firstOnboardingTitle,
                                description: "Get closer to feedback cycle.\nMake honest, trusted and\n accurate feedback"),
                OnboardingModel(imageName: "recognize",
                                title: secondOnboardingTitle,
                                description: "Recognize those who deserve it\n by giving a punctuation based\n on our core values"),
                OnboardingModel(imageName: "rankme",
                                title: thirdOnboardingTitle,
                                description: "Interact with others and be the\n best you can be")]
    }()
    
    var modelsCount: Int {
        return onboardingModel.count
    }
    
    func modelForIndex(index: Int?, direction: ControllerDirection = .idle) -> OnboardingModel? {
        guard var index = index else { return nil }
        index = direction == .before ? index - 1 : direction == .after ? index + 1 : index
        guard 0 ... onboardingModel.count - 1  ~= index else { return nil }
        
        return onboardingModel[index]
    }
    
    func indexForModel(model: OnboardingModel?) -> Int? {
        return onboardingModel.firstIndex { $0.imageName == model?.imageName && $0.title == model?.title && $0.description == model?.description}
    }
    
}
