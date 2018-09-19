//
//  WNFormatUtil.swift
//  WhatsNow
//
//  Created by David Buhauer on 19/09/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit

class WNFormatUtil {
    
    // MARK: - Date & Time
    static func formatDate(_ dateString: String) -> String {

        if let date: Date = self.dateFormatter().date(from: dateString) {
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "eee dd MMM yyyy"
            
            return dateFormatter.string(from: date)
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
    
    private static func dateFormatter() -> DateFormatter{
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter
    }
}
