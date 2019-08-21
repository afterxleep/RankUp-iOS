//
//  UILabel+Multicolor.swift
//  RankUp
//
//  Created by Daniel Bernal on 8/21/19.
//

import UIKit

extension UILabel {
    
    func setViewTitleAttributes() {
        guard let wordArray = self.text?.components(separatedBy: " "), let text = self.text, wordArray.count == 2 else { return }
            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: text)
            attributedString.setColor(color: UIColor.white, forText: wordArray[0])
            attributedString.setColor(color: UIColor.aquaBlue, forText: wordArray[1])
            attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 18.0, weight: .heavy), range: NSRange(location: 0, length: text.count))
            self.attributedText = attributedString
    }
    
}
