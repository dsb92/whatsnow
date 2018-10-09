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

enum WNURLParameterValue: String {
    case none = "none"
    case organizer = "organizer"
    case venue = "venue"
    case date = "date"
    case category = "category"
    case startAsc = "start_asc"
    case startDesc = "start_desc"
}

enum WNURLParameterKey: String {
    case none = "none"
    case locationAddress = "location.address"
    case expand = "expand"
    case sortBy = "sort_by"
    case orderBy = "order_by"
    case categories = "categories"
}

protocol WNDataControllerEventsDelegate: class {
    func dataControllerDidFetchEvents(_ parser: WNEventsParser)
}

class WNDataController: NSObject {
    static let shared: WNDataController = WNDataController()
    
    private let BASE_URL: String = "https://www.eventbriteapi.com/v3"
    
    weak var eventsDelegate: WNDataControllerEventsDelegate?
    
    override init() {
        super.init()
    }
    
    // MARK: - Search events
    func searchEvents(fromAddress address: String) {
        self.searchEvents(fromParamDic: [WNURLParameterKey.locationAddress: [address.encodeToUrl],
                                           WNURLParameterKey.expand: [WNURLParameterValue.organizer.rawValue, WNURLParameterValue.venue.rawValue, WNURLParameterValue.category.rawValue],
                                           WNURLParameterKey.sortBy: [WNURLParameterValue.date.rawValue]])
    }
    
    func searchEvents(fromAddress address: String, andCategoryId categoryId: String) {
        self.searchEvents(fromParamDic: [WNURLParameterKey.locationAddress: [address.encodeToUrl],
                                         WNURLParameterKey.categories: [categoryId],
                                         WNURLParameterKey.expand: [WNURLParameterValue.organizer.rawValue, WNURLParameterValue.venue.rawValue, WNURLParameterValue.category.rawValue],
                                         WNURLParameterKey.sortBy: [WNURLParameterValue.date.rawValue]])
    }
    
    private func searchEvents(fromParamDic paramDic: [WNURLParameterKey: [String]]) {
        
        let requestUrl: String = self.getRequestUrl(from: "\(BASE_URL)/events/search?", andParamDic: paramDic)
        
        print("Fetching \(requestUrl)...")
        
        Alamofire.request(requestUrl)
            .validate()
            .responseObject { (response: DataResponse<WNEventsParser>) in

                guard let eventParser: WNEventsParser = response.result.value, let events: [WNEvent] = eventParser.events else { return }
                
                print("Fetched \(String(describing: events.count))")
                self.eventsDelegate?.dataControllerDidFetchEvents(eventParser)
        }
    }
    
    // MARK: - Organizer
    func getEventsByOrganizerId(_ organizerId: Int) {
        self.getEventsByOrganizerId(organizerId, fromParamDic: [WNURLParameterKey.expand: [WNURLParameterValue.organizer.rawValue, WNURLParameterValue.venue.rawValue, WNURLParameterValue.category.rawValue],
                                                                WNURLParameterKey.orderBy: [WNURLParameterValue.startAsc.rawValue]])
    }
    
    private func getEventsByOrganizerId(_ organizerId: Int, fromParamDic paramDic: [WNURLParameterKey: [String]]) {
        let requestUrl: String = self.getRequestUrl(from: "\(BASE_URL)/organizers/\(organizerId)/events?", andParamDic: paramDic)
        
        print("Fetching \(requestUrl)...")
        
        Alamofire.request(requestUrl)
            .validate()
            .responseObject { (response: DataResponse<WNEventsParser>) in
                
                guard let eventParser: WNEventsParser = response.result.value, let events: [WNEvent] = eventParser.events else { return }
                
                print("Fetched \(String(describing: events.count)) from \(organizerId)...")
                self.eventsDelegate?.dataControllerDidFetchEvents(eventParser)
        }
    }
    
    private func getCommaSeperatedDataString(_ data: [String]) -> String {
        var dataString: String = ""
        data.forEach { (d: String) in
            dataString += d
            
            if d != data.last {
                dataString += ","
            }
        }
        
        return dataString
    }
    
    private func getRequestUrl(from baseUrl: String, andParamDic paramDic: [WNURLParameterKey: [String]]) -> String {
        var requestUrl: String = baseUrl
        
        let keys: [WNURLParameterKey] = paramDic.keys.compactMap { $0 }
        
        keys.forEach { (key: WNURLParameterKey) in
            if let values: [String] = paramDic[key] {
                let commaSeperatedString: String = self.getCommaSeperatedDataString(values.compactMap { $0 })
                
                requestUrl += String(format: "%@=%@", key.rawValue, commaSeperatedString)
                
                if key != keys.last {
                    requestUrl += "&"
                } else {
                    requestUrl += String(format: "&%@=%@", "token", "U6FBWNSAJ6ZUKS3B3VY7")
                }
            }
        }
        
        return requestUrl
    }
}
