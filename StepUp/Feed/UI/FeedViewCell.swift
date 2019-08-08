//
//  FeedViewCell.swift
//  StepUp
//
//  Created by Miguel Rojas on 7/28/19.
//

import UIKit

final class FeedViewCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: FeedViewCell.self)
    
    @IBOutlet weak private var userImageView: UIImageView!
    @IBOutlet weak private var userNameLabel: UILabel!
    @IBOutlet weak private var valueView: UIView!
    @IBOutlet weak private var valueLabel: UILabel!
    @IBOutlet weak private var feedbackLabel: UILabel!
    @IBOutlet weak private var elapsedTimeLabel: UILabel!
    @IBOutlet weak private var rankLabel: UILabel!
    @IBOutlet weak private var byLineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        valueView.roundCorners(radius: 6)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
