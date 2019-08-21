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
        static let sectionHeaderID = String(describing: UITableViewHeaderFooterView.self)
        static let headerHeight: CGFloat = 55
        static let headerTitleRecommended = "OR PICK A CONTACT FROM YOUR CIRCLE"
        static let headerTitleSearchResults = "SEARCH RESULTS"
        static let headerFontSize: CGFloat = 15
        static let headerMargin: CGFloat = 20
        static let viewTitle = "New Feedback"
    }
    
    //MARK: - Stored Properties
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var toLabel: UILabel!    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = FeedbackSearchPeopleViewModel(apiClient: APIClient())
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        registerForKeyboardNotifications()
        registerTableViews()
        searchTxtField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchContacts()
    }
    
    //MARK: - Private
    
    private func registerTableViews() {
        tableView.register(UITableViewHeaderFooterView.classForCoder(), forHeaderFooterViewReuseIdentifier: Constants.sectionHeaderID)
    }
    
    private func fetchContacts(withQuery query: String? = nil) {
        
        // Fetch relevant contacts
        if(query == nil) {
            viewModel.fetchRelevantContacts { [weak self]  in
                guard
                    let strongSelf = self
                    else { return }
                if strongSelf.tableView.numberOfRows(inSection: 0) == 0 {
                    strongSelf.loader.stopAnimating()
                    strongSelf.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
                } else {
                    strongSelf.tableView.reloadData()
                    strongSelf.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                }
            }
        }
        
        // Or perform the search when query is provided
        
    }
    
    //MARK: - Configure
    
    private func configure() {
        toLabel.text = Constants.toLabel
        searchTxtField.placeholder = Constants.searchFieldPlaceholder
        
        let titleLabel = UILabel()
        titleLabel.text = Constants.viewTitle
        titleLabel.setViewTitleAttributes()
        self.navigationItem.titleView = titleLabel
    }
    

}

extension FeedbackSearchPeopleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchResults?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.contact(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactViewCell.reuseIdentifier) as! ContactViewCell
        cell.configure(withModel: model)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.headerHeight
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.sectionHeaderID) else { return nil }
        header.contentView.backgroundColor = .almostWhiteGray
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: Constants.headerFontSize, weight: .heavy)
        titleLabel.text = Constants.headerTitleRecommended
        titleLabel.sizeToFit()
        header.contentView.addSubview(titleLabel)
        titleLabel.centerYAnchor.constraint(equalTo: header.contentView.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: header.contentView.leadingAnchor, constant: Constants.headerMargin).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: header.contentView.trailingAnchor, constant: Constants.headerMargin).isActive = true
        return header
    }
}


extension FeedbackSearchPeopleViewController: UITableViewDelegate {
}


extension FeedbackSearchPeopleViewController: UITextFieldDelegate {
    
    private func textViewDidBeginEditing(_ textView: UITextView) {
        
    }
    
    private func textViewDidEndEditing(_ textView: UITextView) {
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
    }
    
}

