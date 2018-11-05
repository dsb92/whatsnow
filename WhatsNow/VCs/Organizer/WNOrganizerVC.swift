//
//  WNOrganizerVC.swift
//  WhatsNow
//
//  Created by David Buhauer on 09/10/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit

class WNOrganizerVC: WNEventsVC {
    
    var event: WNEvent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let event: WNEvent = self.event else { return }
        
        self.title = event.organizer?.name
        
        self.refreshData()
    }
    
    override func refreshData() {
        guard let event: WNEvent = self.event else { return }
        
        if let organizerId: Int = Int(event.organizer?.id ?? "") {
            self.dataCon.getEventsByOrganizerId(organizerId)
        }
    }
}
