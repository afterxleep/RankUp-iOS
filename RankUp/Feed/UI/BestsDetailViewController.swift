//
//  BestsDetailViewController.swift
//  RankUp
//
//  Created by Miguel D Rojas Cortés on 8/19/19.
//

import UIKit

final class BestsDetailViewController: UIViewController {
    
    //MARK: - Stored Properties
    
    @IBOutlet weak private var viewContainer: UIView!
    @IBOutlet weak private var profileView: ProfileView!
    @IBOutlet weak private var valueLabel: UILabel!
    @IBOutlet weak private var scoreLabel: UILabel!
    @IBOutlet weak private var userNameLabel: UILabel!
    @IBOutlet weak private var jobTitleLabel: UILabel!
    @IBOutlet weak private var feedbackLabel: UILabel!
    @IBOutlet weak private var elapsedTimeLabel: UILabel!
    @IBOutlet weak private var byLineLabel: UILabel!
    
    var viewModel = BestsDetailViewModel()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundCorners()
        configure()
    }
    
    //MARK: - Configuration
    
    private func configure() {
        profileView.configure(withName: viewModel.detail?.userName, userMSID: viewModel.detail?.userMSID)
        valueLabel.text = viewModel.detail?.valueName?.uppercased()
        valueLabel.textColor = UIHelper.valueColor(forType: viewModel.detail?.valueName)
        
        if let score = viewModel.detail?.score {
            scoreLabel.text = "\(score)"
        }

        userNameLabel.text = viewModel.detail?.userName
        jobTitleLabel.text = viewModel.detail?.jobTitle
        feedbackLabel.text = #""\#(viewModel.detail?.feedback ?? "Nothing to see here")""#
        elapsedTimeLabel.text = viewModel.detail?.createdTime?.formattedElapsedTime()
        byLineLabel.text = "By \(viewModel.detail?.author ?? "Some shy Endavan")"
    }
    
    private func roundCorners() {
        viewContainer.roundCorners(radius: 33)
        profileView.roundCorners(radius: 15)
    }
    
    //MARK: - Actions
    
    @IBAction private func didTapBackground(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
