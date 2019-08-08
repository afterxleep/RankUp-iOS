//
//  UIHelper.swift
//  StepUp
//
//  Created by Miguel Rojas on 8/7/19.
//

import UIKit

struct UIHelper {
    
    static func lineHeightAttribute(size: CGFloat, alignment: NSTextAlignment = .center) -> NSParagraphStyle {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = size
        paragraphStyle.maximumLineHeight = size
        paragraphStyle.alignment = alignment
        
        return paragraphStyle
    }
    
}
