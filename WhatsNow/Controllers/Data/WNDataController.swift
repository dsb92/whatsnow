//
//  WNDataController.swift
//  WhatsNow
//
//  Created by David Buhauer on 16/09/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

protocol WNDataControllerEventsDelegate: class {
    func dataControllerDidFetchEvents(_ parser: WNEventsParser)
}

class WNDataController: NSObject {
    static let shared: WNDataController = WNDataController()
    
    struct Auth {
        static let Token: String = "U6FBWNSAJ6ZUKS3B3VY7"
    }
    
    weak var eventsDelegate: WNDataControllerEventsDelegate?
    
    override init() {
        super.init()
    }
    
    func fetchEvents(fromLocationAddress address: String) {
        print("Fetching events from \(address)...")
        Alamofire.request("https://www.eventbriteapi.com/v3/events/search?location.address=\(address)&expand=organizer,venue&token=\(Auth.Token)")
            .validate()
            .responseObject { (response: DataResponse<WNEventsParser>) in
                
                guard let eventParser: WNEventsParser = response.result.value, let events: [WNEvent] = eventParser.events else { return }
                
                print("Fetched \(String(describing: events.count)) from \(address)...")
                self.eventsDelegate?.dataControllerDidFetchEvents(eventParser)
        }
    }
}
