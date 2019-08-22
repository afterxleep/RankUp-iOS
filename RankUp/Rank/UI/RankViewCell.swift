//
//  RankViewCell.swift
//  RankUp
//
//  Created by Miguel D Rojas Cortés on 8/20/19.
//

import UIKit

final class RankViewCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: RankViewCell.self)
    
    @IBOutlet weak private var rankLabel: UILabel!
    @IBOutlet weak private var rankImageView: UIImageView!
    @IBOutlet weak private var profileView: ProfileView!
    @IBOutlet weak private var userNameLabel: UILabel!
    @IBOutlet weak private var jobTitleLabel: UILabel!
    @IBOutlet weak private var pointsLabel: UILabel!
    
    // MARK: - Configuration
    
    func configure(with model: Contact?, index: Int) {
        guard let contact = model else { return }
        clearData()
        
        if 0...2 ~= index {
            rankLabel.textColor = .aquaBlue
            rankImageView.image = UIImage(named: "podium")
        } else {
            rankImageView.image = nil
            rankLabel.textColor = .black
        }
        
        rankLabel.text = String(describing: index + 1)
        profileView.configure(withName: contact.name, userMSID: contact.msid)
        userNameLabel.text = contact.name
        jobTitleLabel.text = contact.jobTitle
        pointsLabel.text = "9999"
    }
    
    private func clearData() {
        rankLabel.text = nil
        userNameLabel.text = nil
        jobTitleLabel.text = nil
        pointsLabel.text = nil
        profileView.reset()
    }
    
}
