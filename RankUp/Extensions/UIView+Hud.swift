//
//  UIView+Hud.swift
//  RankUp
//
//  Created by Daniel Bernal on 8/19/19.
//

import UIKit
import JGProgressHUD

extension UIView {
    
    public func displaySuccessHudWithText(text: String, andDuration duration: Double) {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = text
        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
        hud.show(in: self)
        hud.dismiss(afterDelay: duration)
    }
    
}
