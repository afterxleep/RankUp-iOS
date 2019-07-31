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
    @IBOutlet weak private var scoreLabel: UILabel!
    @IBOutlet weak private var userNameLabel: UILabel!
    @IBOutlet weak private var feedbackLabel: UILabel!
    @IBOutlet weak private var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
