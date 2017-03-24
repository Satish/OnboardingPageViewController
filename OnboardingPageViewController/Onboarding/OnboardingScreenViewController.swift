//
//  OnboardingScreenViewController.swift
//  OnboardingPageViewController
//
//  Created by Satish Chauhan on 3/24/17.
//  Copyright © 2017 Satish. All rights reserved.
//

import UIKit

class OnboardingScreenViewController: UIViewController {

    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var bgImageView: UIImageView!

    var message: String?
    var bgImageName: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }

    private func updateUI() {
        messageLabel.text = message

        if let imageName = bgImageName {
            bgImageView.image = UIImage(named: imageName)
        }
    }

}
