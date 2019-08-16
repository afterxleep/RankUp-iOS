//
//  FeedViewCell.swift
//  RankUp
//
//  Created by Miguel Rojas on 7/28/19.
//

import UIKit

final class FeedViewCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: FeedViewCell.self)
    
    @IBOutlet weak private var profileView: ProfileView!
    @IBOutlet weak private var userNameLabel: UILabel!
    @IBOutlet weak private var valueView: UIView!
    @IBOutlet weak private var valueLabel: UILabel!
    @IBOutlet weak private var feedbackLabel: UILabel!
    @IBOutlet weak private var elapsedTimeLabel: UILabel!
    @IBOutlet weak private var rankLabel: UILabel!
    @IBOutlet weak private var byLineLabel: UILabel!
    
    // MARK: - Overrides
    
    override func awakeFromNib() {
        super.awakeFromNib()
        valueView.roundCorners(radius: 6)
    }
    
    // MARK: - Interface
    
    func configure(withModel model: Feedback?) {
        guard let model = model else { return }
        resetContent()
        
        userNameLabel.text = model.to?.name
        feedbackLabel.text = model.comment
        valueLabel.text = model.value?.name?.uppercased()
        valueLabel.textColor = UIHelper.valueColor(forType: model.value?.name)
        valueView.backgroundColor = UIHelper.valueColor(forType: model.value?.name)
        elapsedTimeLabel.text = model.createdAt?.formattedElapsedTime()
        rankLabel.attributedText = UIHelper.createAttributedAttachmentText(string: "\(model.likes ?? 0)", leadingAttachment: "rankLike")
        let fromName = model.from?.name ?? "Anonymous"
        byLineLabel.text = "Rank by \(fromName)"
        profileView.configure(withName: model.to?.name)
        profileView.fetchProfilePhoto(userMSID: model.to?.msid)
    }
    
    private func resetContent() {
        userNameLabel.text = nil
        feedbackLabel.text = nil
        valueLabel.text = nil
        byLineLabel.text = nil
        rankLabel.text = nil
        elapsedTimeLabel.text = nil
    }
    
    func fetchProfilePhoto(userMSID: String?, completion: @escaping (UIImage?) -> Void) {
        guard let msid = userMSID else { return }
        APIClient().profilePhoto(userMSID: msid) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    completion(UIImage(data: data, scale: 1.0))
                case .failure( _ ):
                    completion(nil)
                }
            }
        }
    }
    
}
