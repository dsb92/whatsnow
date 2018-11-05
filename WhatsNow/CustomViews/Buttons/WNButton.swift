//
//  WNButton.swift
//  WhatsNow
//
//  Created by David Buhauer on 05/11/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit

class WNButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
    }
    
    func commonInit() {
        self.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton() {
        WNHapticFeedBackUtil.itemSelected()
    }
}
