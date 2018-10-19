//
//  WNFormatUtil.swift
//  WhatsNow
//
//  Created by David Buhauer on 19/09/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit

class WNFormatUtil {
    
    // MARK: - Gradients
    static func themeGradient() -> [UIColor] {
        let topGradient: UIColor = self.themeColorLightBlue()
        let bottomGradient: UIColor = self.themeColorBlue()
        
        return [topGradient, bottomGradient]
    }
    
    static func themeGradientLayer(_ view: UIView, withColors colors: [UIColor]) -> CAGradientLayer {
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = colors.compactMap { $0.cgColor }
        gradientLayer.masksToBounds = true
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        return gradientLayer
    }
    
    static func themeColorBlue() -> UIColor {
        return UIColor(red: 16/255, green: 140/255, blue: 238/255, alpha: 1.0)
    }
    
    static func themeColorLightBlue() -> UIColor {
        return UIColor(red: 18/255, green: 183/255, blue: 231/255, alpha: 1.0)
    }
    
    // MARK: - Buttons
    static func formatActionButton(_ button: UIButton) {
        button.backgroundColor = UIColor.white
        self.formatDefaultShadowAndRadius(button)
    }
    
    static func formatDefaultShadowAndRadius(_ view: UIView) {
        view.layer.cornerRadius = view.bounds.size.width / 2
        view.clipsToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 12
        view.layer.shadowOpacity = 0.15
        view.layer.shadowOffset = CGSize(width: 0, height: 8)
    }
    
    // MARK: - Date & Time
    static func formatDate(_ dateString: String) -> String {

        if let date: Date = self.dateFormatter().date(from: dateString) {
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "eee dd MMM yyyy"
            
            return dateFormatter.string(from: date).capitalizingFirstLetter()
        }
        
        return ""
    }
    
    static func formatTime(_ timeString: String) -> String {
        if let date: Date = self.dateFormatter().date(from: timeString) {
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.timeStyle = .short
            dateFormatter.dateStyle = .none
            dateFormatter.dateFormat = "HH:mm"
            return dateFormatter.string(from: date)
        }
        
        return ""
    }
    
    static func date(fromDateString dateString: String) -> Date {
        if let date: Date = self.dateFormatter().date(from: dateString) {
            return date
        }
        
        return Date()
    }
    
    private static func dateFormatter() -> DateFormatter{
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter
    }
}
