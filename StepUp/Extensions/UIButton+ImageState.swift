//
//  UIButton+ImageState.swift
//  StepUp
//
//  Created by Miguel Rojas on 8/11/19.
//

import UIKit

extension UIButton {
    
    func setBackgroundColor(color: UIColor, state: UIButton.State) {
        let stateImage = imageStateFromColor(color: color)
        setBackgroundImage(stateImage, for: state)
    }
    
    private func imageStateFromColor(color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContext(bounds.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(bounds)
        let stateImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return stateImage
    }
    
}
