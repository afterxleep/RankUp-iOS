//
//  BestViewController.swift
//  StepUp
//
//  Created by Miguel Rojas on 7/28/19.
//

import UIKit

final class BestsViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    let viewModel = BestsViewModel(apiClient: APIClient())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchBestsFeeds { error in
            
        }
    }
    
}

extension BestsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: BestsViewCell.reuseIdentifier, for: indexPath)
    }
    
}
