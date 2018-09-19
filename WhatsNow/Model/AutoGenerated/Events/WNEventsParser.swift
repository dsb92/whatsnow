//
//	WNEventsParser.swift
//
//	Create by David Buhauer on 19/9/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class WNEventsParser : NSObject, NSCoding, Mappable{

	var events : [WNEvent]?
	var location : WNLocation?
	var pagination : WNPagination?


	class func newInstance(map: Map) -> Mappable?{
		return WNEventsParser()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		events <- map["events"]
		location <- map["location"]
		pagination <- map["pagination"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         events = aDecoder.decodeObject(forKey: "events") as? [WNEvent]
         location = aDecoder.decodeObject(forKey: "location") as? WNLocation
         pagination = aDecoder.decodeObject(forKey: "pagination") as? WNPagination

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if events != nil{
			aCoder.encode(events, forKey: "events")
		}
		if location != nil{
			aCoder.encode(location, forKey: "location")
		}
		if pagination != nil{
			aCoder.encode(pagination, forKey: "pagination")
		}

	}

}