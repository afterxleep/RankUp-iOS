//
//  BestViewController.swift
//  StepUp
//
//  Created by Miguel Rojas on 7/28/19.
//

import UIKit

final class BestsViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    //MARK: - Stored Properties
    
    let viewModel = BestsViewModel(apiClient: APIClient())
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchBestsFeeds { [weak self] error in
            guard let strongSelf = self else { return }
            if error == nil {
                strongSelf.collectionView.reloadData()
            }
        }
    }
    
}

extension BestsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfBests
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = viewModel.bestFeed(at: indexPath.item)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestsViewCell.reuseIdentifier, for: indexPath) as! BestsViewCell
        cell.configure(model: model)
        
        return cell
    }
    
}
