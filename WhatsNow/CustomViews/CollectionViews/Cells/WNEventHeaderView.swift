//
//  WNEventHeaderView.swift
//  WhatsNow
//
//  Created by David Buhauer on 26/09/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit

class WNEventHeaderView: UICollectionReusableView {
    @IBOutlet weak var sectionHeaderLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.sectionHeaderLabel.font = WNFormatUtil.boldFont(ofSize: 25)
        self.sectionHeaderLabel.textColor = UIColor.black
    }
}
