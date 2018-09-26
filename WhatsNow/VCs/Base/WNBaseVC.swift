//
//  WNBaseVC.swift
//  WhatsNow
//
//  Created by David Buhauer on 16/09/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit

class WNBaseVC: UIViewController {

    let dataCon: WNDataController = WNDataController.shared
    let locCon: WNLocationController = WNLocationController.shared
    
    lazy var appDelegate: WNAppDelegate = {
        return UIApplication.shared.delegate as? WNAppDelegate ?? WNAppDelegate()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        self.assignDelegates()
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    func assignDelegates() {
    }
    
    func setupUI() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}
