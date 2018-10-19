//
//  WNNoResultsView.swift
//  WhatsNow
//
//  Created by David Buhauer on 19/10/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit

class WNNoResultsView: UIView {
    @IBOutlet var contentView: UIView!
    
    @IBOutlet var label: UILabel!
    @IBOutlet var sublabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadXib()
        self.commonInit()
    }
 
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadXib()
        self.commonInit()
    }
    
    internal func loadXib() {
        Bundle.main.loadNibNamed(String(describing: WNNoResultsView.self), owner: self, options: nil)
        self.addSubview(self.contentView)
        
        self.contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    internal func commonInit() {
    }
}
