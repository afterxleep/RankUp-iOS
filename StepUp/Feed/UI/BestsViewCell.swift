//
//  BestsViewCell.swift
//  StepUp
//
//  Created by Miguel Rojas on 7/28/19.
//

import UIKit

final class BestsViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: BestsViewCell.self)
    
    @IBOutlet weak private var userImageView: UIImageView!
    @IBOutlet weak private var userNameLabel: UILabel!
    @IBOutlet weak private var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
