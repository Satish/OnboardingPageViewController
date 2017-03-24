//
//  UIStoryboard+Extension.swift
//  OnboardingPageViewController
//
//  Created by Satish Chauhan on 3/24/17.
//  Copyright © 2017 Satish. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    // Storyboards Instance
    static var mainStoryboard: UIStoryboard { return UIStoryboard(name: Constants.MainStoryboardName, bundle: NSBundle.mainBundle()) }


    // VCs
    static func onboardingViewController() -> OnboardingScreenViewController {
        return mainStoryboard.instantiateViewControllerWithIdentifier(StoryboardID.OnboardingScreenViewController) as! OnboardingScreenViewController
    }

    static func landingViewController() -> LandingViewController {
        return mainStoryboard.instantiateViewControllerWithIdentifier(StoryboardID.LandingViewController) as! LandingViewController
    }

}

extension UIStoryboard {
    
    private struct Constants {
        static let MainStoryboardName = "Main"
    }

    private struct StoryboardID {
        static let OnboardingScreenViewController = "OnboardingScreenViewControllerSBID"
        static let LandingViewController          = "LandingViewControllerSBID"
    }

}
