//
//  WNSearchEventsVC.swift
//  WhatsNow
//
//  Created by David Buhauer on 16/09/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit
import Hero

class WNEventsVC: WNBaseVC {
    
    @IBOutlet weak var eventCollectionView: WNEventsCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Aarhus"
        
        self.eventCollectionView.eventsCollectionViewDelegate = self
        self.eventCollectionView.delaysContentTouches = false
        
        self.dataCon.fetchEvents(fromLocationAddress: "aarhus")
    }
    
    override func assignDelegates() {
        super.assignDelegates()
        
        self.dataCon.eventsDelegate = self
    }
}

// MARK: - WNEventsCollectionViewDelegate
extension WNEventsVC: WNEventsCollectionViewDelegate {
    func eventsCollectionViewDidSelectEvent(_ sender: WNEventsCollectionView, event: WNEvent) {
        let vc = WNEventDetailVC()
        vc.event = event
        
        vc.hero.isEnabled = true
        vc.hero.modalAnimationType = .none
        
        self.present(vc, animated: true, completion: nil)
    }
}

// MARK: - WNDataControllerEventsDelegate
extension WNEventsVC: WNDataControllerEventsDelegate {
    func dataControllerDidFetchEvents(_ parser: WNEventsParser) {
        guard let events: [WNEvent] = parser.events else { return }
        
        self.eventCollectionView.events = events
    }
}
