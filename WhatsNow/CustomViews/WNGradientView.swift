//
//  WNGradientView.swift
//  WhatsNow
//
//  Created by David Buhauer on 18/10/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit

class WNGradientView: UIView {

    private var gradientLayer: CAGradientLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let gradientLayer_: CAGradientLayer = self.gradientLayer {
            gradientLayer_.frame = self.bounds
        }
    }
    
    func commonInit() {
        
    }
    
    func setGradient(withColors colors: [UIColor]) {
        self.gradientLayer = WNFormatUtil.themeGradientLayer(self, withColors: colors)
    }
}
