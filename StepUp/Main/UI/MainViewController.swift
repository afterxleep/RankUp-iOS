//
//  MainViewController.swift
//  StepUp
//
//  Created by Miguel Rojas on 7/23/19.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var containerView: UIView!
    
    // MARK: - Stored Properties
    
    var viewModel: MainViewModel? = MainViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInitialController()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Route
    
    private func loadInitialController() {
        guard let storyboardName = viewModel?.initialStoryboard else { return }
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() else { return }
        addChildViewController(viewController: controller)
    }
    
    private func addChildViewController(viewController: UIViewController) {
        addChild(viewController)
        guard let childView = viewController.view else { return }
        containerView.addSubview(childView)
        
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        viewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        viewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        viewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        viewController.didMove(toParent: self)
    }
    
    private func removeChildViewController(viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
}
