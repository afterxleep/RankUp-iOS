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
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    
    // MARK: - Actions
    
    @objc private func keyboardWillShow(notification: Notification) {
        handleKeyboardEvent(withNotification: notification)
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        handleKeyboardEvent(withNotification: notification)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Private
    
    private func handleKeyboardEvent(withNotification notification: Notification) {
        guard
            let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let heightDelta = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.size.height else { return }
        
        let keyboardWillShow = notification.name == UIResponder.keyboardWillShowNotification
        let defaultYPosition = view.frame.origin.y
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: animationDuration,
                                                       delay: 0,
                                                       options: .layoutSubviews,
                                                       animations: { [weak self] in
                                                        guard let strongSelf = self else { return }
                                                        
                                                        let yPosition = keyboardWillShow ? (defaultYPosition - heightDelta) : (defaultYPosition + heightDelta)
                                                        strongSelf.view.frame = CGRect(origin: CGPoint(x: strongSelf.view.frame.origin.x, y: yPosition),
                                                                                       size: strongSelf.view.frame.size)
            }, completion: nil)
    }
    
}
