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
    
    let onboardingModel: [OnboardingViewModel] = {
        let onboardingAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 28.0, weight: .black), .kern: 0.39, .paragraphStyle: UIHelper.lineHeightAttribute(size: 28)]
        
        let obOne = NSMutableAttributedString(string: "Closer\n", attributes: [.foregroundColor: UIColor.dark])
        obOne.append(NSAttributedString(string: "FeedBack", attributes: [.foregroundColor: UIColor.aquaBlue]))
        obOne.addAttributes(onboardingAttributes, range: NSRange(location: 0, length: obOne.length))
        
        let obTwo = NSMutableAttributedString(string: "Recognize\n", attributes: [.foregroundColor: UIColor.dark])
        obTwo.append(NSAttributedString(string: "your peer", attributes: [.foregroundColor: UIColor.aquaBlue]))
        obTwo.addAttributes(onboardingAttributes, range: NSRange(location: 0, length: obTwo.length))
        
        let obThree = NSMutableAttributedString(string: "Rank", attributes: [.foregroundColor: UIColor.dark])
        obThree.append(NSAttributedString(string: "me", attributes: [.foregroundColor: UIColor.aquaBlue]))
        obThree.addAttributes(onboardingAttributes, range: NSRange(location: 0, length: obThree.length))
        
        return [OnboardingViewModel(imageName: "feedback",
                                    title: obOne,
                                    description: "Get closer to feedback cycle.\nMake honest, trusted and\n accurate feedback"),
                OnboardingViewModel(imageName: "recognize",
                                    title: obTwo,
                                    description: "Recognize those who deserve it\n by giving a punctuation based\n on our core values"),
                OnboardingViewModel(imageName: "rankme",
                                    title: obThree,
                                    description: "Interact with others and be the\n best you can be")]
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
