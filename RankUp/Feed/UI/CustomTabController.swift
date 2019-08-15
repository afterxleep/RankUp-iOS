//
//  CustomTabController.swift
//  RankUp
//
//  Created by Miguel Rojas on 8/9/19.
//

import UIKit

final class MainTabController: UITabBarController {
    
    private struct Constants {
        static let firstLineTitleAttrs: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleLabel = UILabel(frame: .zero)
        titleLabel.attributedText = UIHelper.createAttributedTitle(firstLine: "Rank", secondLine: "Up", firstLineAttrs: Constants.firstLineTitleAttrs)
        navigationItem.titleView = titleLabel
        let leftImageView = UIImageView(frame: .zero)
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        leftImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        leftImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        leftImageView.image = UIImage(named: "leProfile")
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftImageView)
        navigationItem.leftBarButtonItem?.action = #selector(didTapProfileButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "rankAdd"), style: .done, target: self, action: #selector(didTapNewRankButton))
    }

    @objc private func didTapProfileButton() {
        
    }
    
    @objc private func didTapNewRankButton() {
        
    }
    
}
