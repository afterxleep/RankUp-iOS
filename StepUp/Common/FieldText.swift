//
//  FieldText.swift
//  StepUp
//
//  Created by Miguel Rojas on 7/31/19.
//

import UIKit

final class FieldText: UITextField {
    
    private struct Constants {
        static let defaultRectInsets = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 12)
        static let promptBrandColor = UIColor.black
        static let rightViewPadding: CGFloat = 9
    }
    
    // MARK: - Overrides
    
    override func didMoveToSuperview() {
        tintColor = Constants.promptBrandColor
        borderStyle = .none
        clipsToBounds = true
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: Constants.defaultRectInsets)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: Constants.defaultRectInsets)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        guard
            let rightViewWidth = rightView?.frame.width,
            let rightViewHeight = rightView?.frame.height else { return CGRect(x: bounds.width, y: bounds.height, width: 0, height: 0) }

        let yCoordinate = (bounds.height / 2) - (rightViewHeight / 2)
        
        return CGRect(x: (bounds.width - rightViewWidth) - Constants.rightViewPadding, y: yCoordinate, width: rightViewWidth, height: rightViewHeight)
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(UIResponderStandardEditActions.select(_:)) ||
            action == #selector(UIResponderStandardEditActions.selectAll(_:)) ||
            action == #selector(UIResponderStandardEditActions.copy(_:))
    }
    
}
