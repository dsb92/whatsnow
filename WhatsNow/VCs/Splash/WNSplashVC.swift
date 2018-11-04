//
//  WNSplashVC.swift
//  WhatsNow
//
//  Created by David Buhauer on 04/11/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit
import LTMorphingLabel

protocol WNSplashVCDelegate: class {
    func splashVcDidFinishPresenting(_ sender: WNSplashVC)
}

class WNSplashVC: WNBaseVC {
    @IBOutlet weak var titleLabel: LTMorphingLabel!
    @IBOutlet weak var subTitleLabel: LTMorphingLabel!
    
    weak var delegate: WNSplashVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        super.setupUI()
        
        self.titleLabel.font = WNFormatUtil.boldFont(ofSize: 32)
        self.titleLabel.textColor = UIColor.white
        self.titleLabel.text = "launchscreen_title".localized
        self.titleLabel.delegate = self
        
        self.subTitleLabel.font = WNFormatUtil.mediumFont(ofSize: 24)
        self.subTitleLabel.textColor = UIColor.white
        self.subTitleLabel.morphingCharacterDelay = 0.07
        self.subTitleLabel.delegate = self
        self.subTitleLabel.text = ""
        self.subTitleLabel.stop()
    }
}

extension WNSplashVC: LTMorphingLabelDelegate {
    func morphingDidStart(_ label: LTMorphingLabel) {
        
    }
    
    func morphingOnProgress(_ label: LTMorphingLabel, progress: Float) {
        
    }
    
    func morphingDidComplete(_ label: LTMorphingLabel) {
        if label == self.titleLabel {
            self.subTitleLabel.text = "launchscreen_message".localized
            self.subTitleLabel.start()
        } else {
            self.delegate?.splashVcDidFinishPresenting(self)
        }
    }
}
