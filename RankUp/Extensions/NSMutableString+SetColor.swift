//
//  NSMutableString+SetColor.swift
//  RankUp
//
//  Created by Daniel Bernal on 8/21/19.
//

import UIKit

extension NSMutableAttributedString {
    func setColor(color: UIColor, forText stringValue: String) {
        let range: NSRange = self.mutableString.range(of: stringValue, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
    
}
