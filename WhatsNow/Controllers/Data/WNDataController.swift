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

protocol WNDataControllerOrganizerDelegate: class {
    func dataControllerDidFetchEventsByOrganizer(_ parser: WNEventsParser)
}

class WNDataController: NSObject {
    static let shared: WNDataController = WNDataController()
    
    private let BASE_URL: String = "https://www.eventbriteapi.com/v3"
    
    struct Auth {
        static let Token: String = "U6FBWNSAJ6ZUKS3B3VY7"
    }
    
    weak var eventsDelegate: WNDataControllerEventsDelegate?
    weak var organizerDelegate: WNDataControllerOrganizerDelegate?
    
    override init() {
        super.init()
    }
    
    func fetchEvents(fromLocationAddress address: String) {
        let requestUrl: String = "\(BASE_URL)/events/search?location.address=\(address.encodeToUrl)&expand=organizer,venue&sort_by=date&token=\(Auth.Token)"
        
        print("Fetching \(requestUrl)...")
        
        Alamofire.request(requestUrl)
            .validate()
            .responseObject { (response: DataResponse<WNEventsParser>) in

                guard let eventParser: WNEventsParser = response.result.value, let events: [WNEvent] = eventParser.events else { return }
                
                print("Fetched \(String(describing: events.count)) from \(address)...")
                self.eventsDelegate?.dataControllerDidFetchEvents(eventParser)
        }
    }
    
    func fetchEvents(byOrganizerId organizerId: Int) {
        let requestUrl: String = "\(BASE_URL)/organizers/\(organizerId)/events?expand=organizer,venue&page=1&token=\(Auth.Token)"
        
        print("Fetching \(requestUrl)...")
        
        Alamofire.request(requestUrl)
            .validate()
            .responseObject { (response: DataResponse<WNEventsParser>) in
                
                guard let eventParser: WNEventsParser = response.result.value, let events: [WNEvent] = eventParser.events else { return }
                
                print("Fetched \(String(describing: events.count)) from \(organizerId)...")
                self.organizerDelegate?.dataControllerDidFetchEventsByOrganizer(eventParser)
        }
    }
}
