//
//  UIHelper.swift
//  RankUp
//
//  Created by Miguel Rojas on 8/7/19.
//

import UIKit

enum ValueType: String, CaseIterable {
    case open
    case trust
    case smart
    case thoughtful
    case adaptable
}

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
    
    static func createAttributedAttachmentText(string: String, leadingAttachment: String) -> NSAttributedString {
        let attachment = NSTextAttachment()
        let attachmentFrame = CGRect(origin: .zero, size: CGSize(width: 13, height: 13))
        attachment.image = UIImage(named: leadingAttachment)
        attachment.bounds = attachmentFrame
        
        let attributedAttachment = NSAttributedString(attachment: attachment)
        
        let attributedString = NSMutableAttributedString(attributedString: attributedAttachment)
        attributedString.addAttributes([.baselineOffset : -1], range: NSRange(location: 0, length: attributedAttachment.length))
        attributedString.append(NSAttributedString(string: string))
        
        return attributedString
    }
    
    static func valueColor(forType type: String?) -> UIColor {
        guard
            let type = type,
            let value = ValueType.allCases.first(where: { $0.rawValue == type.lowercased() })
            else { return UIColor.white }
        
        switch value {
        case .open:
            return UIColor.lightishBlue
        case .trust:
            return UIColor.yellowishOrange
        case .smart:
            return UIColor.magenta
        case .thoughtful:
            return UIColor.coolGreen
        case .adaptable:
            return UIColor.aquaBlue
        }
    }
    
}
