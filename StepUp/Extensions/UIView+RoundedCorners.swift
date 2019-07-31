//
//  UIView+RoundedCorners.swift
//  StepUp
//
//  Created by Miguel D Rojas Cortés on 7/30/19.
//

import UIKit

extension UIView {
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat, shadow: Bool = false) {
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        layer.mask = maskLayer
        
        if shadow {
            applyShadow(maskLayer: maskLayer)
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
