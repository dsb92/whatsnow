//
//  WNHapticFeedBackUtil.swift
//  WhatsNow
//
//  Created by David Buhauer on 16/10/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit

class WNHapticFeedBackUtil: NSObject {
    private static let impact = UIImpactFeedbackGenerator()
    private static let selection = UISelectionFeedbackGenerator()
    private static let notification = UINotificationFeedbackGenerator()
    
    static func itemSelected() {
        self.selection.selectionChanged()
    }
    
    static func successPressed() {
        self.notification.notificationOccurred(.success)
    }
    
    static func warningPressed() {
        self.notification.notificationOccurred(.warning)
    }
    
    static func errorPressed() {
        self.notification.notificationOccurred(.error)
    }
}
