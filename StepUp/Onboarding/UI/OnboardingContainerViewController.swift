//
//  OnboardingContainerViewController.swift
//  Travelers
//
//  Created by Miguel Rojas on 28/07/18.
//

import UIKit

final class OnboardingContainerViewController: UIViewController {
    
    @IBOutlet weak private var pageControl: UIPageControl!
    @IBOutlet weak private var skipButton: UIButton!
    
    // MARK: - Stored Properties
    
    private var pageController: UIPageViewController!    
    var viewModel: OnboardingContainerViewModel? = OnboardingContainerViewModel()
    
    private var currentControllerIndex: Int {
        guard let currentController = pageController.viewControllers?.first as? OnboardingViewController else { return 0 }
        return viewModel?.indexForModel(model: currentController.viewModel) ?? 0
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePageController()
        configurePageControl()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageVC = segue.destination as? UIPageViewController {
            pageController = pageVC
        }
    }
    
    // MARK: - Configuration
    
    private func configurePageController() {
        pageController.dataSource = self
        pageController.delegate = self
        
        guard let controller = controller(forIndex: 0) else { return }
        
        pageController.setViewControllers([controller],
                                          direction: .forward,
                                          animated: false,
                                          completion: nil)
    }
    
    private func configurePageControl() {
        pageControl.currentPage = 0
        pageControl.numberOfPages = viewModel?.modelsCount ?? 0
    }
    
    private func controller(forIndex index: Int?, direction: ControllerDirection = .idle) -> OnboardingViewController? {
        guard let viewModel = viewModel?.modelForIndex(index: index, direction: direction) else { return nil }
        let storyboard = UIStoryboard(name: K.Storyboards.onboarding, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: K.SBIDs.onboarding) as? OnboardingViewController
        
        controller?.viewModel = viewModel
        
        return controller
    }
    
}

extension OnboardingContainerViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return controller(forIndex: currentControllerIndex, direction: .before)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return controller(forIndex: currentControllerIndex, direction: .after)
    }
    
}

extension OnboardingContainerViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let onboardingModels = viewModel?.modelsCount else { return }
        skipButton.setTitle(currentControllerIndex < onboardingModels - 1 ? "Skip" : "Done", for: .normal)
        pageControl.currentPage = currentControllerIndex
    }
    
}
