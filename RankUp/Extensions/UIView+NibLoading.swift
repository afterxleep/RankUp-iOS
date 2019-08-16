//
//  UIView+NibLoading.swift
//  RankUp
//
//  Created by Miguel Rojas on 8/16/19.
//

import UIKit

extension UIView {
    
    func loadNib() {
        let nibName = String(describing: type(of: self))
        guard let contentView = Bundle.main.loadNibNamed(nibName, owner: self)?.first as? UIView else { return }
        addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
}
