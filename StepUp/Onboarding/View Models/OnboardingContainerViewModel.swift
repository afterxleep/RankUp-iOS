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
    
    private struct Constants {
        static let firstLineAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.dark]
        static let secondLineAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.aquaBlue]
        static let onboardingAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 28.0, weight: .black),
                                                                          .kern: 0.39, .paragraphStyle: UIHelper.lineHeightAttribute(size: 28)]
    }
    
    // MARK: - Interface
    
    let onboardingModel: [OnboardingModel] = {
        
        let firstOnboardingTitle = createAttributedOnboardingTitle(firstLine: "Closer\n", secondLine: "FeedBack")
        let secondOnboardingTitle = createAttributedOnboardingTitle(firstLine: "Recognize\n", secondLine: "your peer")
        let thirdOnboardingTitle = createAttributedOnboardingTitle(firstLine: "Rank", secondLine: "me")
        
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
    
    // MARK: - Private
    
    static private func createAttributedOnboardingTitle(firstLine: String, secondLine: String) -> NSAttributedString {
        let onboardingTitle = NSMutableAttributedString(string: firstLine, attributes: Constants.firstLineAttributes)
        onboardingTitle.append(NSAttributedString(string: secondLine, attributes: Constants.secondLineAttributes))
        onboardingTitle.addAttributes(Constants.onboardingAttributes, range: NSRange(location: 0, length: onboardingTitle.length))
        
        return onboardingTitle
    }
    
}
