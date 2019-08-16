//
//  ProfileView.swift
//  RankUp
//
//  Created by Miguel Rojas on 8/16/19.
//

import UIKit

final class ProfileView: UIView {
    
    private struct Constants {
        static let profileViewRadius: CGFloat = 15
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet weak private var userImageView: UIImageView!
    @IBOutlet weak private var placeholderView: UIView!
    @IBOutlet weak private var profileInitials: UILabel!
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    // MARK: - Life Cycle
    
    override func didMoveToSuperview() {
        userImageView.roundCorners(radius: Constants.profileViewRadius)
        placeholderView.roundCorners(radius: Constants.profileViewRadius)
    }
    
    // MARK: - Interface
    
    func configure(withName name: String?) {
        if let userNames = name?.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true) {
            profileInitials.text = userNames.reduce(into: "") { result, substring in
                result?.append(String(substring.first ?? Character("")))
            }
        } else {
            profileInitials.text = "ED"
        }
    }
    
    func fetchProfilePhoto(userMSID: String? = nil) {
        guard let msid = userMSID else { return }
        APIClient().profilePhoto(userMSID: msid) { [weak self] result in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
                        strongSelf.userImageView.image = UIImage(data: data, scale: 1.0)
                        strongSelf.userImageView.alpha = 1.0
                    })
                case .failure(_):
                    break
                }
            }
        }
    }
    
}
