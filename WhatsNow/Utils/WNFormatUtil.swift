//
//  WNFormatUtil.swift
//  WhatsNow
//
//  Created by David Buhauer on 19/09/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit

class WNFormatUtil {
    
    // MARK: - Buttons
    static func formatActionButton(_ button: UIButton) {
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = button.bounds.size.width / 2
        button.clipsToBounds = false
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 12
        button.layer.shadowOpacity = 0.15
        button.layer.shadowOffset = CGSize(width: 0, height: 8)
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
