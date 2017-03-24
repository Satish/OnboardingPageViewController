//
//  OnboardingPageViewController.swift
//  OnboardingPageViewController
//
//  Created by Satish Chauhan on 3/24/17.
//  Copyright © 2017 Satish. All rights reserved.
//

import UIKit

protocol OnboardingPageViewControllerDelegate: class {
    func onboarding(pageViewController: OnboardingPageViewController, didUpdatePageCount count: Int)
    func onboarding(pageViewController: OnboardingPageViewController, didUpdatePageIndex index: Int)
}

class OnboardingPageViewController: UIPageViewController {
    
    weak var onboardingDelegate: OnboardingPageViewControllerDelegate?
    
    var onboardingViewControllers = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self

        onboardingViewControllers.append(screenViewController(backgroundColor: UIColor.grayColor(), message: "Screen 1"))
        onboardingViewControllers.append(screenViewController(backgroundColor: UIColor.brownColor(), message: "Screen 2"))
        onboardingViewControllers.append(screenViewController(backgroundColor: UIColor.darkGrayColor(), message: "Screen 3"))
        onboardingViewControllers.append(screenViewController(backgroundColor: UIColor.lightGrayColor(), message: "Screen 4"))
        onboardingViewControllers.append(UIStoryboard.landingViewController())

        onboardingDelegate?.onboarding(self, didUpdatePageCount: onboardingViewControllers.count)
        if let firstViewController = onboardingViewControllers.first {
            scrollToViewController(firstViewController)
        }
    }

    func scrollToNextViewController() {
        if let visibleViewController = viewControllers?.first,
            let nextViewController = pageViewController(self, viewControllerAfterViewController: visibleViewController) {
            scrollToViewController(nextViewController)
        }
    }

    func scrollToViewController(index index: Int) {
        if let firstViewController = viewControllers?.first,
            let currentIndex = onboardingViewControllers.indexOf(firstViewController) {
            let direction: UIPageViewControllerNavigationDirection = index >= currentIndex ? .Forward : .Reverse
            let nextViewController = onboardingViewControllers[index]
            scrollToViewController(nextViewController, direction: direction)
        }
    }

    private func scrollToViewController(viewController: UIViewController, direction: UIPageViewControllerNavigationDirection = .Forward) {
        setViewControllers([viewController], direction: direction, animated: true, completion: { (finished) -> Void in
            self.pageViewControllerDidFinishAnimating()
        })
    }

    private func screenViewController(backgroundColor backgroundColor: UIColor, message: String) -> UIViewController {
        let screenVC = UIStoryboard.onboardingViewController()
        screenVC.message = message
        screenVC.view.backgroundColor = backgroundColor
        
        return screenVC
    }

}

extension OnboardingPageViewController: UIPageViewControllerDelegate {

    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        pageViewControllerDidFinishAnimating()
    }

    private func pageViewControllerDidFinishAnimating() {
        if let firstViewController = viewControllers?.first,
            let index = onboardingViewControllers.indexOf(firstViewController) {
            onboardingDelegate?.onboarding(self, didUpdatePageIndex: index)
        }
    }

}

extension OnboardingPageViewController: UIPageViewControllerDataSource {

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let index = onboardingViewControllers.indexOf(viewController) else {
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
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let index = onboardingViewControllers.indexOf(viewController) else {
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
