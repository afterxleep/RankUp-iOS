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
    @IBOutlet weak private var valueView: UIView!
    @IBOutlet weak private var scoreLabel: UILabel!
    @IBOutlet weak private var userNameLabel: UILabel!
    @IBOutlet weak private var jobTitleLabel: UILabel!
    @IBOutlet weak private var feedbackLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        valueView.roundCorners(corners: .allCorners, radius: 9)
    }
    
}
