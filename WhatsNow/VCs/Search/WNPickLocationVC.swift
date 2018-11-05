//
//  WNPickLocationVC.swift
//  WhatsNow
//
//  Created by David Buhauer on 04/11/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit

protocol WNPickLocationVCDelegate: class {
    func pickLocationVcDidPickLocation(_ sender: WNPickLocationVC, pickedLocation: String)
}

class WNPickLocationVC: WNBaseVC {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pickCityButton: WNGradientButton!
    @IBOutlet weak var useCurrentLocationButton: WNMyLocationButton!
    
    var cityForCurrentEvents: String = String() {
        didSet {
            self.delegate?.pickLocationVcDidPickLocation(self, pickedLocation: self.cityForCurrentEvents)
        }
    }
    
    lazy var pickCityVc: WNPickCityVC = {
       return WNPickCityVC(delegate: self)
    }()
    
    var delegate: WNPickLocationVCDelegate?
    
    init(delegate: WNPickLocationVCDelegate) {
        super.init(nibName: nil, bundle: nil)
        
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    }
    
    private func useCurrentLocation() {
        self.locCon.requestMyLocation()
        self.locCon.delegate = self
    }
    
    @IBAction func didTapPickCityButton(_ sender: Any) {
        self.present(self.pickCityVc, animated: true, completion: nil)
    }
    
    @IBAction func didTapUseCurrentLocation(_ sender: Any) {
        self.useCurrentLocation()
    }
}

// MARK: - WNPickCityVCDelegate
extension WNPickLocationVC: WNPickCityVCDelegate {
    func pickCityVcDidSelectCurrentLocation(_ sender: WNPickCityVC) {
        self.pickCityVc.dismiss(animated: true) {
            self.useCurrentLocation()
        }
    }
    
    func pickCityVcDidSelectCity(_ sender: WNPickCityVC, location: WNPopularLocation) {
        self.pickCityVc.dismiss(animated: true) {
            self.cityForCurrentEvents = location.city
        }
    }
}

// MARK: - WNLocationControllerDelegate
extension WNPickLocationVC: WNLocationControllerDelegate {
    func locationControllerDidChangeCity(_ sender: WNLocationController, city: String) {
        if city.lowercased() != self.cityForCurrentEvents.lowercased() {
            self.cityForCurrentEvents = city
        }
    }
}
