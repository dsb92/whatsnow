//
//  WNThreeCircleSpinner.swift
//  WhatsNow
//
//  Created by David Buhauer on 18/10/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit
import ALThreeCircleSpinner

class WNThreeCircleSpinner: ALThreeCircleSpinner {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
    }
    
    private func commonInit() {
        self.tintColor = WNFormatUtil.themeColorBlue()
    }
}
