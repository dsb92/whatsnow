//
//  WNLocationController.swift
//  WhatsNow
//
//  Created by David Buhauer on 26/09/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit
import CoreLocation
import Contacts

protocol WNLocationControllerDelegate: class {
    func locationControllerDidChangeCity(_ sender: WNLocationController, city: String)
}

class WNLocationController: NSObject {
    static let shared: WNLocationController = WNLocationController()
    
    private let locationManager: CLLocationManager = CLLocationManager()
    
    var currentCityLocation: String = String() {
        didSet {
            
        }
    }
    
    weak var delegate: WNLocationControllerDelegate?
    
    override init() {
        super.init()
    }
    
    func requestMyLocation() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.delegate = self
        self.startLocateMe()
    }
    
    func startLocateMe() {
        self.locationManager.startUpdatingLocation()
    }
    
    func stopLocateMe() {
        self.locationManager.stopUpdatingLocation()
    }
}

// MARK: - CLLocationManagerDelegate
extension WNLocationController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            self.startLocateMe()
            break
        case .authorizedWhenInUse:
            self.startLocateMe()
            break
        case .denied:
            self.stopLocateMe()
            break
        case .restricted:
            self.stopLocateMe()
            break
        case .notDetermined:
            self.stopLocateMe()
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocation = locations.first else { return }
        
        CLGeocoder().reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "en_US")) { (placemarks: [CLPlacemark]?, error: Error?) in
            
            guard let placemarks: [CLPlacemark] = placemarks else { return }
            
            if let placemark: CLPlacemark = placemarks.first {
                guard let postAddress: CNPostalAddress = placemark.postalAddress else { return }
                
                self.delegate?.locationControllerDidChangeCity(self, city: postAddress.city)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error location: \(error.localizedDescription)")
    }
}
