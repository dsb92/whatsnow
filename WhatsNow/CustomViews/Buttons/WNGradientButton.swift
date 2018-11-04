//
//  WNGradientButton.swift
//  WhatsNow
//
//  Created by David Buhauer on 18/10/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit

class WNGradientButton: WNRoundedButton {
    
    private var gradientLayer: CAGradientLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let gradientLayer_: CAGradientLayer = self.gradientLayer {
            gradientLayer_.frame = self.bounds
        }
    }
    
    override func commonInit() {
        super.commonInit()
        
        // Default values
        self.setGradient(withColors: WNFormatUtil.themeGradient())
        
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    }
    
    func setGradient(withColors colors: [UIColor]) {
        self.gradientLayer = WNFormatUtil.themeGradientLayer(self, withColors: colors)
    }
}
