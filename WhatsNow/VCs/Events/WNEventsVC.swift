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
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshCon:UIRefreshControl = UIRefreshControl()
        refreshCon.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        return refreshCon
    }()
    
    var cityForCurrentEvents: String = String() {
        didSet {
            self.title = self.cityForCurrentEvents
        }
    }
    
    var requestMyLocation: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.appDelegate.tabBarCon.delegate = self
        
        self.eventCollectionView.eventsCollectionViewDelegate = self
        self.eventCollectionView.delaysContentTouches = false
        self.eventCollectionView.addSubview(self.refreshControl)
        
        if self.requestMyLocation {
            self.locCon.requestMyLocation()
            self.locCon.delegate = self
        }
    }
    
    override func assignDelegates() {
        super.assignDelegates()
        
        self.dataCon.eventsDelegate = self
    }
    
    @objc func refreshData() {
        self.dataCon.searchEvents(fromAddress: self.cityForCurrentEvents)
    }
}

// MARK: - WNLocationControllerDelegate
extension WNEventsVC: WNLocationControllerDelegate {
    func locationControllerDidChangeCity(_ sender: WNLocationController, city: String) {
        if city.lowercased() != self.cityForCurrentEvents.lowercased() {
            self.dataCon.searchEvents(fromAddress: city)
            self.cityForCurrentEvents = city
        }
    }
}

// MARK: - WNEventsCollectionViewDelegate
extension WNEventsVC: WNEventsCollectionViewDelegate {
    func eventsCollectionViewDidSelectEvent(_ sender: WNEventsCollectionView, event: WNEvent) {
        self.presentEventDetail(withEvent: event)
    }
}

// MARK: - WNDataControllerEventsDelegate
extension WNEventsVC: WNDataControllerEventsDelegate {
    func dataControllerDidFetchEvents(_ parser: WNEventsParser) {
        self.refreshControl.endRefreshing()
        
        guard let events: [WNEvent] = parser.events else { return }
        
        var eventsDictionary: [String: [WNEvent]] = [String: [WNEvent]]()
        var sortedKeys: [String] = [String]()
        
        for event in events {
            if let start = event.start {
                let eventDateString: String = WNFormatUtil.formatDate(start.utc ?? "")
                if var originalEvents_ = eventsDictionary[eventDateString] {
                    
                    let exists = originalEvents_.first { $0.id?.lowercased() == event.id?.lowercased() }
                    
                    if exists == nil {
                        originalEvents_.append(event)
                    }
                    
                    eventsDictionary[eventDateString] = originalEvents_
                } else {
                    eventsDictionary[eventDateString] = [event]
                }
                
                if !sortedKeys.contains(eventDateString) {
                    sortedKeys.append(eventDateString)
                }
            }
        }
        
        self.eventCollectionView.sortedKeys = sortedKeys
        self.eventCollectionView.eventsDic = eventsDictionary
    }
}

// MARK: - UITabBarControllerDelegate
extension WNEventsVC: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        
        if tabBarIndex == 0 {
            self.eventCollectionView.setContentOffset(CGPoint.zero, animated: true)
        }
    }
}
