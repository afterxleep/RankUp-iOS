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
    }
    
    //MARK: - Stored Properties
    
    @IBOutlet weak private var tableView: UITableView!
    
    let viewModel = FeedViewModel(apiClient: APIClient())
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableViews()
        viewModel.fetchFeeds { [weak self] error in
            guard let strongSelf = self else { return }
            if error == nil {
                strongSelf.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            }
        }
    }
    
    //MARK: - Private
    
    private func registerTableViews() {
        tableView.register(UITableViewHeaderFooterView.classForCoder(), forHeaderFooterViewReuseIdentifier: Constants.sectionHeaderID)
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
        return 55
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.sectionHeaderID) else { return nil }
        header.contentView.backgroundColor = .white
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        titleLabel.text = "RECENT FEEDBACKS"
        titleLabel.sizeToFit()
        header.contentView.addSubview(titleLabel)
        
        titleLabel.centerYAnchor.constraint(equalTo: header.contentView.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: header.contentView.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: header.contentView.trailingAnchor, constant: 20).isActive = true
        
        return header
    }
    
}

extension FeedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let flagAction = UIContextualAction(style: .normal, title: "Report") { [weak self] _, _, successHandler in
            guard let strongSelf = self else { return }
            strongSelf.viewModel.flagFeedback(at: indexPath.row, completion: { success, error in
                if success {
                    strongSelf.tableView.deleteRows(at: [indexPath], with: .left)
                }
            })
        }
        
        flagAction.backgroundColor = .red
        flagAction.image = UIImage(named: "flag")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [flagAction])
        
        return swipeConfiguration
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let rankAction = UIContextualAction(style: .normal, title: "Boost") { [weak self] _, _, successHandler in
            guard let strongSelf = self else { return }
        }
        
        rankAction.backgroundColor = UIColor.aquaBlue
        rankAction.image = UIImage(named: "rank")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [rankAction])
        
        return swipeConfiguration
    }
    
}
