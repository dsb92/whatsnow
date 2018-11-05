//
//  WNTabBarController.swift
//  WhatsNow
//
//  Created by David Buhauer on 17/09/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit

class WNTabBarController: UITabBarController {

    var statusBarStyle: UIStatusBarStyle = .lightContent {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.statusBarStyle
    }
    
    override var childViewControllerForStatusBarStyle: UIViewController? {
        return nil
    }
}
