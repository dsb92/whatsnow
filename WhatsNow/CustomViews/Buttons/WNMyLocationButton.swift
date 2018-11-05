//
//  WNMyLocationButton.swift
//  WhatsNow
//
//  Created by David Buhauer on 04/11/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit

class WNMyLocationButton: WNButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
    }
    
    override func commonInit() {
        super.commonInit()
        
        self.setTitle("pick_location_use_current".localized, for: .normal)
        self.setTitleColor(UIColor.black, for: .normal)
        self.tintColor = UIColor.black
        self.setImage(UIImage(named: "icon_my_location_black.png"), for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
    }
}
