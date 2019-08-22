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
        static let logoImage = "logo"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logo = UIImage(named: Constants.logoImage)
        let logoImageView = UIImageView(image:logo)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.widthAnchor.constraint(equalToConstant: 85.51).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 26).isActive = true
        self.navigationItem.titleView = logoImageView
        
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
        self.performSegue(withIdentifier: K.Segues.feedbackSegue, sender: nil)
    }
    
}
