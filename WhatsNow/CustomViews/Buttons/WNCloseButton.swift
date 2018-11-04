//
//  WNCloseButton.swift
//  WhatsNow
//
//  Created by David Buhauer on 04/11/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit

class WNCloseButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
    }
    
    func commonInit() {
        self.setImage(UIImage(named: "ic_close.png"), for: .normal)
    }
}
