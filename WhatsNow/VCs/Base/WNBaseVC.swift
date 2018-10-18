//
//  WNBaseVC.swift
//  WhatsNow
//
//  Created by David Buhauer on 16/09/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit
import SnapKit

class WNBaseVC: UIViewController {

    let dataCon: WNDataController = WNDataController.shared
    let locCon: WNLocationController = WNLocationController.shared
    
    lazy var appDelegate: WNAppDelegate = {
        return UIApplication.shared.delegate as? WNAppDelegate ?? WNAppDelegate()
    }()
    
    lazy var progressSpinner: WNThreeCircleSpinner =
        {
            let progressSpinner: WNThreeCircleSpinner = WNThreeCircleSpinner(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
            
            progressSpinner.layer.zPosition = 10
            self.view.addSubview(progressSpinner)
            self.view.bringSubview(toFront: progressSpinner)
            progressSpinner.snp.makeConstraints({ (make) in
                make.centerX.equalTo(self.view).offset(-22)
                make.centerY.equalTo(self.view)
            })
            return progressSpinner
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
    
    func presentEventDetail(withEvent event: WNEvent) {
        let vc = WNEventDetailVC()
        vc.event = event
        
        vc.hero.isEnabled = true
        vc.hero.modalAnimationType = .none
        
        let navCon: UINavigationController = UINavigationController(rootViewController: vc)
        
        navCon.hero.isEnabled = true
        navCon.hero.modalAnimationType = .none
        
        self.present(navCon, animated: true, completion: nil)
    }
    
    func presentShareController(withEvent event: WNEvent) {
        let shareText: String = event.url ?? ""
        let shareCon: UIActivityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        self.present(shareCon, animated: true, completion: nil)
    }
}
