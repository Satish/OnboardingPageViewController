//
//  OnboardingViewController.swift
//  OnboardingPageViewController
//
//  Created by Satish Chauhan on 3/24/17.
//  Copyright © 2017 Satish. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    @IBOutlet weak private var nextButton: UIButton!
    @IBOutlet weak private var containerView: UIView!
    @IBOutlet weak private var pageControl: UIPageControl! {
        didSet {
            pageControl.addTarget(self, action: #selector(OnboardingViewController.didChangePageControlValue), forControlEvents: .ValueChanged)
        }
    }

    var onboardingPageViewController: OnboardingPageViewController? {
        didSet {
            onboardingPageViewController?.onboardingDelegate = self
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let pageViewController = segue.destinationViewController as? OnboardingPageViewController {
            onboardingPageViewController = pageViewController
        }
    }

    @IBAction private func nextButtonTapped(sender: UIButton) {
        if pageControl.currentPage+1 >= pageControl.numberOfPages {
            updateRootViewController()
        } else {
            nextButton.hidden = false
            pageControl.hidden = false
            onboardingPageViewController?.scrollToNextViewController()
        }
    }
    
    func didChangePageControlValue() {
        onboardingPageViewController?.scrollToViewController(index: pageControl.currentPage)
    }

    func updateRootViewController() {
        nextButton.hidden = true
        pageControl.hidden = true
        //view.window?.rootViewController = UIStoryboard.landingViewController()
    }
    
}

extension OnboardingViewController: OnboardingPageViewControllerDelegate {
    
    func onboarding(pageViewController: OnboardingPageViewController, didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func onboarding(pageViewController: OnboardingPageViewController, didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
        
        if index+1 >= pageControl.numberOfPages {
            updateRootViewController()
        } else {
            nextButton.hidden = false
            pageControl.hidden = false
        }
    }
    
}

