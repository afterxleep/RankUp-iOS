//
//  MainViewController.swift
//  StepUp
//
//  Created by Miguel Rojas on 7/23/19.
//

import UIKit

final class MainViewController: UIViewController {
    
    private enum ApplicationState {
        case firstLaunch
        case defaultNavigation
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var containerView: UIView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        NotificationCenter.default.addObserver(self, selector: #selector(routeToTrips), name: K.Notifications.onboardingDidFinishNotification, object: nil)
        
        if UserDefaults.standard.bool(forKey: K.firstLaunchKey) {
            route(to: .defaultNavigation)
        } else {
            route(to: .firstLaunch)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Route
    
    private func route(to state: ApplicationState) {
        let storyboardName = state == .defaultNavigation ? K.Storyboards.feed : K.Storyboards.authentication
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
    
    @objc private func routeToTrips() {
        guard let childVC = children.first else { return }
        removeChildViewController(viewController: childVC)
        route(to: .defaultNavigation)
    }
    
}
