//
//  OnboardingViewController.swift
//  OnboardingPageViewController
//
//  Created by Satish Chauhan on 3/24/17.
//  Copyright © 2017 Satish. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    @IBOutlet weak fileprivate var nextButton: UIButton!
    @IBOutlet weak fileprivate var containerView: UIView!
    @IBOutlet weak fileprivate var pageControl: UIPageControl! {
        didSet {
            pageControl.addTarget(self, action: #selector(OnboardingViewController.didChangePageControlValue), for: .valueChanged)
        }
    }

    var onboardingPageViewController: OnboardingPageViewController? {
        didSet {
            onboardingPageViewController?.onboardingDelegate = self
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageViewController = segue.destination as? OnboardingPageViewController {
            onboardingPageViewController = pageViewController
        }
    }

    @IBAction fileprivate func nextButtonTapped(_ sender: UIButton) {
        if pageControl.currentPage+1 >= pageControl.numberOfPages {
            updateRootViewController()
        } else {
            nextButton.isHidden = false
            pageControl.isHidden = false
            onboardingPageViewController?.scrollToNextViewController()
        }
    }
    
    func didChangePageControlValue() {
        onboardingPageViewController?.scrollToViewController(index: pageControl.currentPage)
    }

    func updateRootViewController() {
        nextButton.isHidden = true
        pageControl.isHidden = true
        //view.window?.rootViewController = UIStoryboard.landingViewController()
    }
    
}

extension OnboardingViewController: OnboardingPageViewControllerDelegate {
    
    func onboarding(_ pageViewController: OnboardingPageViewController, didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func onboarding(_ pageViewController: OnboardingPageViewController, didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
        
        if index+1 >= pageControl.numberOfPages {
            updateRootViewController()
        } else {
            nextButton.isHidden = false
            pageControl.isHidden = false
        }
    }
    
}

