//
//  FeedViewController.swift
//  RankUp
//
//  Created by Miguel Rojas on 7/28/19.
//

import UIKit

final class FeedViewController: UIViewController {
    
    private struct Constants {
        static let sectionHeaderID = String(describing: UITableViewHeaderFooterView.self)
        static let headerHeight: CGFloat = 55
        static let headerTitle = "LATEST FEEDBACKS"
        static let headerFontSize: CGFloat = 15
        static let headerMargin: CGFloat = 20
        static let trailingActionTitle = "Report"
        static let leadingActionTitle = "Boost"
        static let trailingActionImage = "flag"
        static let leadingActionImage = "rank"
        static let boostedMessage = "Feedback Boosted!"
        static let flaggedMessage = "Reported as innapropiate!"
        static let alreadyBoosterMessage = "You already boosted this!"
        static let messagesDuration = 1.0
    }
    
    //MARK: - Stored Properties
    
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var loader: UIActivityIndicatorView!
    
    let viewModel = FeedViewModel(apiClient: APIClient())
    var selectedFeedback: Int?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViews()        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFeeds()
    }
    
    /* Test Scenario to give feedback.
     This should be moved to the search results table or fucking profile view with a couple of buttons with options (recognise/improve)
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? FeedBackTypeViewController,
            let selectedFeedbackIndex = selectedFeedback {
            
            destination.viewModel.feedback = viewModel.feedbackModel(at: selectedFeedbackIndex)
        }
    }
    
    //MARK: - Private
    
    private func registerTableViews() {
        tableView.register(UITableViewHeaderFooterView.classForCoder(), forHeaderFooterViewReuseIdentifier: Constants.sectionHeaderID)
    }
    
    private func fetchFeeds() {
        viewModel.fetchFeeds { [weak self] error in
            guard
                let strongSelf = self,
                error == nil
                else { return }
            
            if strongSelf.tableView.numberOfRows(inSection: 0) == 0 {
                strongSelf.loader.stopAnimating()
                strongSelf.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            } else {
                strongSelf.tableView.reloadData()
                //strongSelf.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        }
    }
    
}

extension FeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfFeeds
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.feedback(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedViewCell.reuseIdentifier) as! FeedViewCell
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
        titleLabel.text = Constants.headerTitle
        titleLabel.sizeToFit()
        header.contentView.addSubview(titleLabel)
        
        titleLabel.centerYAnchor.constraint(equalTo: header.contentView.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: header.contentView.leadingAnchor, constant: Constants.headerMargin).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: header.contentView.trailingAnchor, constant: Constants.headerMargin).isActive = true
        
        return header
    }
    
}

extension FeedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let flagAction = UIContextualAction(style: .normal, title: Constants.trailingActionTitle) { [weak self] _, _, successHandler in
            guard let strongSelf = self else { return }
            strongSelf.viewModel.flagFeedback(at: indexPath.row, completion: { success, error in
                strongSelf.view.displaySuccessHudWithText(text: Constants.flaggedMessage, andDuration: Constants.messagesDuration)
                if success {
                    strongSelf.tableView.deleteRows(at: [indexPath], with: .left)
                }
            })
        }
        
        flagAction.backgroundColor = .red
        flagAction.image = UIImage(named: Constants.trailingActionImage)
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [flagAction])
        
        return swipeConfiguration
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let rankAction = UIContextualAction(style: .normal, title: Constants.leadingActionTitle) { [weak self] _, _, successHandler in
            guard let strongSelf = self else { return }
            strongSelf.tableView.setEditing(false, animated: true)
            if (!strongSelf.viewModel.isLikedFeedback(at: indexPath.row)) {
                strongSelf.viewModel.likeFeedback(at: indexPath.row, completion: { success, error in
                    strongSelf.view.displaySuccessHudWithText(text: Constants.boostedMessage, andDuration: Constants.messagesDuration)
                    if success {
                        strongSelf.fetchFeeds()
                    }
                })
            }
            else {
                strongSelf.view.displaySuccessHudWithText(text: Constants.alreadyBoosterMessage, andDuration: Constants.messagesDuration)
            }
        }
        
        rankAction.backgroundColor = UIColor.aquaBlue
        rankAction.image = UIImage(named: Constants.leadingActionImage)
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [rankAction])
        
        return swipeConfiguration
    }
    
}
