//
//  UIHelper.swift
//  StepUp
//
//  Created by Miguel Rojas on 8/7/19.
//

import UIKit

struct UIHelper {
    
    private struct Constants {
        static let firstLineAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.dark]
        static let secondLineAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.aquaBlue]
        static let onboardingAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 28.0, weight: .black),
                                                                          .kern: 0.39, .paragraphStyle: UIHelper.lineHeightAttribute(size: 28)]
    }
    
    static func lineHeightAttribute(size: CGFloat, alignment: NSTextAlignment = .center) -> NSParagraphStyle {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = size
        paragraphStyle.maximumLineHeight = size
        paragraphStyle.alignment = alignment
        
        return paragraphStyle
    }
    
    static func createAttributedTitle(firstLine: String, secondLine: String, firstLineAttrs: [NSAttributedString.Key: Any] = Constants.firstLineAttributes, secondLineAttrs: [NSAttributedString.Key: Any] = Constants.secondLineAttributes) -> NSAttributedString {
        let onboardingTitle = NSMutableAttributedString(string: firstLine, attributes: firstLineAttrs)
        onboardingTitle.append(NSAttributedString(string: secondLine, attributes: secondLineAttrs))
        onboardingTitle.addAttributes(Constants.onboardingAttributes, range: NSRange(location: 0, length: onboardingTitle.length))
        
        return onboardingTitle
    }
    
}
