//
//  FeedViewController.swift
//  StepUp
//
//  Created by Miguel Rojas on 7/28/19.
//

import UIKit

final class FeedViewController: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    
    let viewModel = FeedViewModel(apiClient: APIClient())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchFeeds { [weak self] error in
            guard let strongSelf = self else { return }
            if error == nil {
                strongSelf.tableView.dataSource = self
                strongSelf.tableView.delegate = self
                strongSelf.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
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
    
}

extension FeedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let flagAction = UIContextualAction(style: .normal, title: nil) { [weak self] _, _, successHandler in
            guard let strongSelf = self else { return }
        }
        
        flagAction.backgroundColor = .black
        flagAction.image = UIImage(named: "flag")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [flagAction])
        
        return swipeConfiguration
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let rankAction = UIContextualAction(style: .normal, title: nil) { [weak self] _, _, successHandler in
            guard let strongSelf = self else { return }
        }
        
        rankAction.backgroundColor = UIColor.aquaBlue
        rankAction.image = UIImage(named: "rank")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [rankAction])
        
        return swipeConfiguration
    }
    
}
