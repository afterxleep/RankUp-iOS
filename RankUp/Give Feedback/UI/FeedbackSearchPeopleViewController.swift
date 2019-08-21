//
//  FeedbackSearchPeopleViewController.swift
//  RankUp
//
//  Created by Daniel Bernal on 8/20/19.
//

import UIKit

class FeedbackSearchPeopleViewController: UIViewController {

    private struct Constants {
        static let toLabel = "To:"
        static let searchFieldPlaceholder = "Search people by name or email"
    }
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var toLabel: UILabel!    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    let viewModel = FeedbackSearchPeopleViewModel(apiClient: APIClient())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        registerForKeyboardNotifications()
        searchTxtField.delegate = self
        viewModel.fetchRelevantPeople { [weak self] in
            self?.loader.stopAnimating()            
        }
    }
    
    //MARK: - Configure
    
    private func configure() {
        toLabel.text = Constants.toLabel
        searchTxtField.placeholder = Constants.searchFieldPlaceholder
    }
    
}


extension FeedbackSearchPeopleViewController: UITextFieldDelegate {
    
    private func textViewDidBeginEditing(_ textView: UITextView) {
    }
    
    private func textViewDidEndEditing(_ textView: UITextView) {
    }
    
    func textViewDidChange(_ textView: UITextView) {
    }
    
}

