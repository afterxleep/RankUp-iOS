//
//  OnboardingViewController.swift
//  Travelers
//
//  Created by Miguel Rojas on 28/07/18.
//

import UIKit

final class OnboardingViewController: UIViewController {
    
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    
    var viewModel: OnboardingModel?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Configuration
    
    private func configure() {
        if let imageName = viewModel?.imageName, let image = UIImage(named: imageName) {
            imageView.image = image
        }
        
        titleLabel.attributedText = viewModel?.title
        descriptionLabel.text = viewModel?.description
    }
    
}
