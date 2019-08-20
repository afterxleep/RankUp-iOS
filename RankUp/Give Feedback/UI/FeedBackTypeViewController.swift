//
//  FeedBackTypeViewController.swift
//  RankUp
//
//  Created by Miguel D Rojas Cortés on 8/17/19.
//

import UIKit

final class FeedBackTypeViewController: UIViewController {
    
    var viewModel = FeedBackTypeViewModel(apiClient: APIClient())
    private var selectedButtonIndex: Int?
    
    //MARK: - IBOutlets
    
    @IBOutlet weak private var profileView: ProfileView!
    @IBOutlet weak private var userRankLabel: UILabel!
    @IBOutlet weak private var userNameLabel: UILabel!
    @IBOutlet weak private var buttonsContainer: UIStackView!
    @IBOutlet weak private var feedBackTypeLabel: UILabel!
    @IBOutlet weak private var viewContainer: UIView!
    @IBOutlet weak private var loader: UIActivityIndicatorView!
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupValueButtons()
        roundCorners()
        configure()
        viewModel.fetchCompanyValues { [weak self] in
            self?.loader.stopAnimating()
            self?.setupValueButtons()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? FeedbackViewController,
            let buttonIndex = selectedButtonIndex {
            let companyValue = viewModel.valueForIndex(index: buttonIndex)
            destination.viewModel.companyValue = companyValue
            destination.viewModel.feedback = viewModel.feedback
            destination.viewModel.feedBackType = viewModel.feedBackType
        }
    }
    
    //MARK: - Configuration
    
    func configure() {
        userRankLabel.attributedText = UIHelper.createAttributedAttachmentText(string: " \(viewModel.feedback?.userRank ?? "")", leadingAttachment: "rankingTinted")
        userNameLabel.text = viewModel.feedback?.userName
        profileView.configure(withName: viewModel.feedback?.userName, userMSID: viewModel.feedback?.userMSID)
        feedBackTypeLabel.text = viewModel.feedBackType.rawValue
    }
    
    private func roundCorners() {
        viewContainer.roundCorners(corners: [CACornerMask.layerMinXMinYCorner, CACornerMask.layerMaxXMinYCorner], radius: 66)
        profileView.roundCorners(radius: 15)
    }
    
    private func setupValueButtons() {
        for value in viewModel.endavaValues {
            let valueButton = UIButton(type: .custom)
            valueButton.backgroundColor = UIColor.iceBlue
            valueButton.translatesAutoresizingMaskIntoConstraints = false
            let color = UIHelper.valueColor(forType: value.name)
            let buttonTitle = NSAttributedString(string: value.name.uppercased(),
                                                 attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .heavy),
                                                              .foregroundColor: color])
            valueButton.setAttributedTitle(buttonTitle, for: .normal)
            valueButton.roundCorners(radius: 9)
            valueButton.clipsToBounds = true
            valueButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
            valueButton.addTarget(self, action: #selector(didTapValueButton(sender:)), for: .touchUpInside)
            
            buttonsContainer.addArrangedSubview(valueButton)
            
            let borderLayer = CALayer()
            borderLayer.frame = CGRect(origin: CGPoint(x: 0, y: 48), size: CGSize(width: buttonsContainer.frame.size.width, height: 2))
            borderLayer.borderColor = color.cgColor
            borderLayer.borderWidth = 2
            
            valueButton.layer.addSublayer(borderLayer)
        }
    }
    
    //MARK: - Actions
    
    @objc private func didTapValueButton(sender: UIButton) {
        selectedButtonIndex = buttonsContainer.arrangedSubviews.firstIndex(where: { $0 == sender } )
        performSegue(withIdentifier: K.Segues.giveFeedbackSegue, sender: nil)
    }
    
}
