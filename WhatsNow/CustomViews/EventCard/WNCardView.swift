//
//  WNEventCardView.swift
//  WhatsNow
//
//  Created by David Buhauer on 16/09/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit
import SDWebImage

class WNCardView: UIView {
    let titleContainerView = UIView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let imageView = UIImageView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    func commonInit() {
        clipsToBounds = true
        
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 42)
        self.titleLabel.clipsToBounds = false
        self.titleLabel.adjustsFontSizeToFitWidth = true
        self.titleLabel.minimumScaleFactor = 0.5
        self.titleLabel.numberOfLines = 2
        self.titleLabel.lineBreakMode = .byTruncatingTail
        self.titleLabel.textColor = UIColor.black
        self.titleLabel.sizeToFit()
        
        self.subtitleLabel.font = UIFont.systemFont(ofSize: 17)
        self.subtitleLabel.clipsToBounds = false
        self.subtitleLabel.numberOfLines = 1
        self.subtitleLabel.lineBreakMode = .byTruncatingTail
        self.subtitleLabel.textColor = UIColor.lightGray
        self.subtitleLabel.sizeToFit()
        
        self.imageView.contentMode = .scaleAspectFill
        
        self.titleContainerView.backgroundColor = UIColor.white
        
        self.titleContainerView.addSubview(self.titleLabel)
        self.titleContainerView.addSubview(self.subtitleLabel)
        
        self.addSubview(self.imageView)
        self.addSubview(self.titleContainerView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.titleContainerView.frame = CGRect(x: 0, y: bounds.size.height - 120, width: bounds.size.width, height: 120)
        
        self.imageView.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height - self.titleContainerView.bounds.size.height)
        
        self.titleLabel.frame = CGRect(x: 20, y: 45, width: self.titleContainerView.bounds.size.width - 40, height: self.titleLabel.intrinsicContentSize.height)
        self.subtitleLabel.frame = CGRect(x: 20, y: 15, width: self.titleContainerView.bounds.size.width - 40, height: 30)
    }
}
