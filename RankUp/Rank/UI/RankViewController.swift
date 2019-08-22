//
//  RankViewController.swift
//  RankUp
//
//  Created by Miguel D Rojas Cortés on 8/20/19.
//

import UIKit

final class RankViewController: UIViewController {
    
    private struct Constants {
        static let sectionHeaderID = String(describing: UITableViewHeaderFooterView.self)
        static let headerHeight: CGFloat = 55
        static let headerTitle = "BEST RANKING"
        static let headerFontSize: CGFloat = 15
        static let headerMargin: CGFloat = 20
    }
    
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var loader: UIActivityIndicatorView!
    
    let viewModel = RankViewModel(apiClient: APIClient())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: Constants.sectionHeaderID)
        viewModel.fetchRankData { [weak self] success, errorMsg in
            self?.loader.stopAnimating()
            
            if success {
                self?.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            } else {
                print("Screw you: \(errorMsg)")
            }
        }
    }
    
}

extension RankViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfUsers
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.user(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: RankViewCell.reuseIdentifier) as! RankViewCell
        cell.configure(with: model, index: indexPath.row)
        
        return cell
    }
    
}

extension RankViewController: UITableViewDelegate {
    
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
