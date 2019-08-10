//
//  UIViewController+KeyboardHandling.swift
//  Travelers
//
//  Created by Miguel Rojas on 8/8/19.
//

import UIKit

extension UIViewController {
    
    // MARK: - Notifications
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIApplication.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Actions
    
    @objc private func keyboardWillShow(notification: Notification) {
        handleKeyboardEvent(withNotification: notification)
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        handleKeyboardEvent(withNotification: notification)
    }
    
    // MARK: - Private
    
    private func handleKeyboardEvent(withNotification notification: Notification) {
        guard
            let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let heightDelta = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.origin.y else { return }
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: animationDuration, delay: 0, options: .layoutSubviews, animations: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.view.frame = CGRect(origin: strongSelf.view.frame.origin, size: CGSize(width: strongSelf.view.frame.width, height: heightDelta))
            }, completion: nil)
    }
    
}
