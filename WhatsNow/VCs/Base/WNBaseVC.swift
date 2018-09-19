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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.assignDelegates()
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    func assignDelegates() {
    }
}
