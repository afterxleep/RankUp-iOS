//
//  RankViewController.swift
//  RankUp
//
//  Created by Miguel D Rojas Cortés on 8/20/19.
//

import UIKit

final class RankViewController: UIViewController {
    
    let viewModel = RankViewModel(apiClient: APIClient())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchRankData()
    }
    
}
