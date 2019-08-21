//
//  RankViewCell.swift
//  RankUp
//
//  Created by Miguel D Rojas Cortés on 8/20/19.
//

import UIKit

final class RankViewCell: UITableViewCell {

    @IBOutlet weak private var rankLabel: UILabel!
    @IBOutlet weak private var rankImageView: UIImageView!
    @IBOutlet weak private var profileView: ProfileView!
    @IBOutlet weak private var userNameLabel: UILabel!
    @IBOutlet weak private var jobTitleLabel: UILabel!
    @IBOutlet weak private var pointsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
