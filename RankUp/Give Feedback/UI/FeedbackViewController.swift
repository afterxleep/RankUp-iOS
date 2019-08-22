//
//  FeedbackViewController.swift
//  RankUp
//
//  Created by Miguel D Rojas Cortés on 8/18/19.
//

import UIKit

final class FeedbackViewController: UIViewController {
    
    private struct Constants {
        static let feedbackPlaceholder = "Enter your comment (max 140 chars)"
        static let privateTitleLabel = "Keep it private?"
        static let privateExplanationPrefix = "When enabled only"
        static let privateExplanationSuffix = "will see your message"
        static let privateExplanationDefault = "your peer"
        static let feedbackTypeLabel = "I want to:"
        static let feedbackTypeExplanation = ""
        static let viewTitleFirstWord = "New"
        static let viewTitleSecondWord = "Feedback"
    }
    
    @IBOutlet weak private var profileView: ProfileView!
    @IBOutlet weak private var valueView: UIView!
    @IBOutlet weak private var userNameLabel: UILabel!
    @IBOutlet weak private var valueLabel: UILabel!
    @IBOutlet weak private var valueDescriptionLabel: UILabel!
    @IBOutlet weak private var privacySwitch: UISwitch!
    @IBOutlet weak private var feedbackTextView: UITextView!
    @IBOutlet weak private var sendButton: UIButton!
    @IBOutlet weak private var viewContainer: UIView!
    @IBOutlet weak private var privateTitleLabel: UILabel!
    @IBOutlet weak private var privateSubheadLabel: UILabel!
    @IBOutlet weak var feedbackTypeLabel: UILabel!
    @IBOutlet weak var feedbackTypeExplanation: UILabel!
    @IBOutlet weak var recognizeButton: UIButton!
    @IBOutlet weak var adviseButton: UIButton!
    
    var viewModel = FeedbackViewModel(apiClient: APIClient())
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        roundCorners()
        registerForKeyboardNotifications()
        feedbackTextView.delegate = self
        feedbackTextView.textContainerInset = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
    }
    
    //MARK: - Configure
    
    private func configure() {
        userNameLabel.text = viewModel.feedback?.userName
        
        let valueColor = UIHelper.valueColor(forType: viewModel.companyValue?.name)
        
        valueView.backgroundColor = valueColor
        valueLabel.text = viewModel.companyValue?.name.uppercased()
        valueLabel.textColor = valueColor
        valueDescriptionLabel.text = viewModel.companyValue?.description
        
        privateTitleLabel.text = Constants.privateTitleLabel
        privateSubheadLabel.text = "\(Constants.privateExplanationPrefix) \(viewModel.feedback?.userName ?? Constants.privateExplanationDefault) \(Constants.privateExplanationSuffix)"
        
        feedbackTextView.attributedText = NSAttributedString(string: Constants.feedbackPlaceholder,
                                                             attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGreyBlue])
        
        profileView.configure(withName: viewModel.feedback?.userName, userMSID: viewModel.feedback?.userMSID)
        
        feedbackTypeLabel.text = Constants.feedbackTypeLabel
        feedbackTypeExplanation.text = Constants.feedbackTypeExplanation
        
        let titleLabel = UILabel()
        titleLabel.attributedText = UIHelper.createAttributedTitle(firstWord: Constants.viewTitleFirstWord, secondWord: Constants.viewTitleSecondWord)
        self.navigationItem.titleView = titleLabel
        
        enableFeedbackButton(button: recognizeButton)
        
    }
    
    private func roundCorners() {
        valueView.roundCorners(radius: 11)
        viewContainer.roundCorners(corners: [CACornerMask.layerMinXMinYCorner, CACornerMask.layerMaxXMinYCorner], radius: 66)
        feedbackTextView.roundCorners(radius: 9)
        sendButton.roundCorners(radius: 9)
    }
    
    func enableFeedbackButton(button: UIButton) {
        button.titleLabel?.textColor = UIColor.aquaBlue
        button.tintColor = UIColor.aquaBlue
        button.setTitleColor(.aquaBlue, for: .normal)
    }
    
    func disableFeedbackButton(button: UIButton) {
        button.titleLabel?.textColor = UIColor.gray
        button.tintColor = UIColor.gray
        button.setTitleColor(.gray, for: .normal)
    }
    
    
    //MARK: - Actions
    
    @IBAction private func didTapSendButton(_ sender: Any) {
        viewModel.sendFeedBack(comment: feedbackTextView.attributedText.string, isPublic: privacySwitch.isOn) { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @IBAction func didTapRecognizeButton(_ sender: Any) {
        enableFeedbackButton(button: recognizeButton)
        disableFeedbackButton(button: adviseButton)
        viewModel.feedback?.isPublic = true
        privacySwitch.isOn = false
        privacySwitch.isEnabled = true
    }
    
    @IBAction func didTapAdviseButton(_ sender: Any) {
        enableFeedbackButton(button: adviseButton)
        disableFeedbackButton(button: recognizeButton)
        viewModel.feedback?.isPublic = false
        viewModel.feedback?.isPositive = false
        privacySwitch.isOn = true
        privacySwitch.isEnabled = false
        let alertController = UIAlertController(title: "Your feedback will be private", message: "Advise feedback will always be private to the receiving user.  \n\n It will not shown in the general feed.", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: nil)
        alertController.addAction(actionOk)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
}

extension FeedbackViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.attributedText.string == Constants.feedbackPlaceholder {
            textView.text = nil
            textView.typingAttributes = [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.dark]
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.attributedText.string.isEmpty {
            textView.text = Constants.feedbackPlaceholder
            textView.typingAttributes = [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGreyBlue]
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if !textView.attributedText.string.isEmpty {
            sendButton.setBackgroundColor(color: .aquaBlue, state: .normal)
            sendButton.setTitleColor(.white, for: .normal)
            sendButton.isEnabled = true
        } else {
            sendButton.setBackgroundColor(color: .iceBlue, state: .normal)
            sendButton.setTitleColor(.lightGreyBlue, for: .normal)
            sendButton.isEnabled = false
        }
    }
    
}
