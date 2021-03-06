//
//  WNRoundedButton.swift
//  WhatsNow
//
//  Created by David Buhauer on 18/10/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit

class WNRoundedButton: WNButton {

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
        
        self.layer.cornerRadius = self.bounds.height / 2
        self.clipsToBounds = true
    }
}
