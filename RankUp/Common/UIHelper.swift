//
//  UIHelper.swift
//  RankUp
//
//  Created by Miguel Rojas on 8/7/19.
//

import UIKit

enum ValueType: String, CaseIterable {
    case open
    case trusted
    case smart
    case thoughtful
    case adaptable
}

struct UIHelper {
    
    private struct Constants {
        static let firstLineAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
        static let secondLineAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.aquaBlue]
        static let defaultTitleAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 17.0, weight: .black),
                                                                          .kern: 0.39, .paragraphStyle: UIHelper.lineHeightAttribute(size: 17)]
    }
    
    static func lineHeightAttribute(size: CGFloat, alignment: NSTextAlignment = .center) -> NSParagraphStyle {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = size
        paragraphStyle.maximumLineHeight = size
        paragraphStyle.alignment = alignment
        
        return paragraphStyle
    }
    
    static func createAttributedTitle(firstWord: String, secondWord: String, firstLineAttrs: [NSAttributedString.Key: Any] = Constants.firstLineAttributes, secondLineAttrs: [NSAttributedString.Key: Any] = Constants.secondLineAttributes) -> NSAttributedString {
        let title = NSMutableAttributedString(string: firstWord, attributes: firstLineAttrs)
        title.append(NSAttributedString(string: " ", attributes: firstLineAttrs))
        title.append(NSAttributedString(string: secondWord, attributes: secondLineAttrs))
        title.addAttributes(Constants.defaultTitleAttributes, range: NSRange(location: 0, length: title.length))
        return title
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
            return UIColor.open
        case .trusted:
            return UIColor.trust
        case .smart:
            return UIColor.smart
        case .thoughtful:
            return UIColor.thoughful
        case .adaptable:
            return UIColor.adaptable
        }
    }
    
}
