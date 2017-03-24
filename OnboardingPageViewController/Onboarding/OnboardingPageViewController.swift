//
//  OnboardingPageViewController.swift
//  OnboardingPageViewController
//
//  Created by Satish Chauhan on 3/24/17.
//  Copyright © 2017 Satish. All rights reserved.
//

import UIKit

protocol OnboardingPageViewControllerDelegate: class {
    func onboarding(_ pageViewController: OnboardingPageViewController, didUpdatePageCount count: Int)
    func onboarding(_ pageViewController: OnboardingPageViewController, didUpdatePageIndex index: Int)
}

class OnboardingPageViewController: UIPageViewController {
    
    weak var onboardingDelegate: OnboardingPageViewControllerDelegate?
    
    var onboardingViewControllers = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self

        onboardingViewControllers.append(screenViewController(backgroundColor: UIColor.gray, message: "Screen 1"))
        onboardingViewControllers.append(screenViewController(backgroundColor: UIColor.brown, message: "Screen 2"))
        onboardingViewControllers.append(screenViewController(backgroundColor: UIColor.darkGray, message: "Screen 3"))
        onboardingViewControllers.append(screenViewController(backgroundColor: UIColor.lightGray, message: "Screen 4"))
        onboardingViewControllers.append(UIStoryboard.landingViewController())

        onboardingDelegate?.onboarding(self, didUpdatePageCount: onboardingViewControllers.count)
        if let firstViewController = onboardingViewControllers.first {
            scrollToViewController(firstViewController)
        }
    }

    func scrollToNextViewController() {
        if let visibleViewController = viewControllers?.first,
            let nextViewController = pageViewController(self, viewControllerAfter: visibleViewController) {
            scrollToViewController(nextViewController)
        }
    }

    func scrollToViewController(index: Int) {
        if let firstViewController = viewControllers?.first,
            let currentIndex = onboardingViewControllers.index(of: firstViewController) {
            let direction: UIPageViewControllerNavigationDirection = index >= currentIndex ? .forward : .reverse
            let nextViewController = onboardingViewControllers[index]
            scrollToViewController(nextViewController, direction: direction)
        }
    }

    fileprivate func scrollToViewController(_ viewController: UIViewController, direction: UIPageViewControllerNavigationDirection = .forward) {
        setViewControllers([viewController], direction: direction, animated: true, completion: { (finished) -> Void in
            self.pageViewControllerDidFinishAnimating()
        })
    }

    fileprivate func screenViewController(backgroundColor: UIColor, message: String) -> UIViewController {
        let screenVC = UIStoryboard.onboardingViewController()
        screenVC.message = message
        screenVC.view.backgroundColor = backgroundColor
        
        return screenVC
    }

}

extension OnboardingPageViewController: UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        pageViewControllerDidFinishAnimating()
    }

    fileprivate func pageViewControllerDidFinishAnimating() {
        if let firstViewController = viewControllers?.first,
            let index = onboardingViewControllers.index(of: firstViewController) {
            onboardingDelegate?.onboarding(self, didUpdatePageIndex: index)
        }
    }

}

extension OnboardingPageViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = onboardingViewControllers.index(of: viewController) else {
            return nil
        }

        let previousIndex = index - 1
        guard previousIndex >= 0 else {
            return nil
        }

        guard onboardingViewControllers.count > previousIndex else {
            return nil
        }

        return onboardingViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = onboardingViewControllers.index(of: viewController) else {
            return nil
        }

        let nextIndex = index + 1
        let onboardingViewControllersCount = onboardingViewControllers.count

        guard onboardingViewControllersCount > nextIndex else {
            return nil
        }

        return onboardingViewControllers[nextIndex]
    }
    
}
