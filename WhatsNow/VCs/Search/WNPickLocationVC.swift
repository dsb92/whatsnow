//
//  WNPickLocationVC.swift
//  WhatsNow
//
//  Created by David Buhauer on 04/11/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit

class WNPickLocationVC: WNBaseVC {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pickCityButton: WNGradientButton!
    @IBOutlet weak var useCurrentLocationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        super.setupUI()
        
        self.titleLabel.font = WNFormatUtil.semiBoldFont(ofSize: 38)
        self.titleLabel.textColor = UIColor.black
        self.titleLabel.text = "pick_location_where_go_out_title".localized
        
        self.subTitleLabel.font = WNFormatUtil.regularFont(ofSize: 18)
        self.subTitleLabel.textColor = UIColor.black
        self.subTitleLabel.text = "pick_location_where_go_out_message".localized
        
        self.imageView.image = UIImage(named: "image_pick_city.png")?.withRenderingMode(.alwaysTemplate)
        self.imageView.tintColor = WNFormatUtil.themeColorBlue()
        
        self.pickCityButton.setGradient(withColors: WNFormatUtil.themeGradient())
        self.pickCityButton.setTitle("pick_location_city".localized, for: .normal)
        self.pickCityButton.setTitleColor(UIColor.white, for: .normal)
        
        self.useCurrentLocationButton.setTitle("pick_location_use_current".localized, for: .normal)
        self.useCurrentLocationButton.setTitleColor(UIColor.black, for: .normal)
        self.useCurrentLocationButton.tintColor = UIColor.black
        self.useCurrentLocationButton.setImage(UIImage(named: "icon_my_location_black.png"), for: .normal)
    }
    
    @IBAction func didTapPickCityButton(_ sender: Any) {
    }
    
    @IBAction func didTapUseCurrentLocation(_ sender: Any) {
    }
}
