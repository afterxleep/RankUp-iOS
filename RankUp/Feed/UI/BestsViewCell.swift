//
//  BestsViewCell.swift
//  RankUp
//
//  Created by Miguel Rojas on 7/28/19.
//

import UIKit

final class BestsViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: BestsViewCell.self)
    
    @IBOutlet weak private var profileView: ProfileView!
    @IBOutlet weak private var valueView: UIView!
    @IBOutlet weak private var userNameLabel: UILabel!
    @IBOutlet weak private var feedbackLabel: UILabel!
    
    //MARK: - Life Cycle
    
    override func awakeFromNib() {
        valueView.roundCorners(radius: 6)
    }
    
    //MARK: - Configuration
    
    func configure(model: Feedback?) {
        guard let model = model else { return }
        resetContent()
        userNameLabel.text = model.to?.name
        valueView.backgroundColor = UIHelper.valueColor(forType: model.value?.name)
        let comment = model.comment ?? "Nothing to see here..."
        feedbackLabel.text = #""\#(comment)""#
        profileView.configure(withName: model.to?.name, userMSID: model.to?.msid)
    }
    
    private func resetContent() {
        userNameLabel.text = nil
        feedbackLabel.text = nil
    }
    
}
