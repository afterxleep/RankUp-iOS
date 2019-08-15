//
//  UIView+RoundedCorners.swift
//  RankUp
//
//  Created by Miguel D Rojas Cortés on 7/30/19.
//

import UIKit

extension UIView {
    
    func roundCorners(corners: CACornerMask? = nil, radius: CGFloat, shadow: Bool = false) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        
        if let corners = corners {
            self.layer.maskedCorners = corners
        }
    }
    
    private func applyShadow(maskLayer: CAShapeLayer) {
        maskLayer.shadowColor = UIColor(white: 0.1, alpha: 0.8).cgColor
        maskLayer.shadowOffset = CGSize(width: 1, height: -8)
        maskLayer.shadowOpacity = 1.0
        maskLayer.shadowRadius = 4
        maskLayer.masksToBounds = false
        layer.shadowPath = maskLayer.path
    }
    
}
