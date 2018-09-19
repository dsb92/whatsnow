//
//	WNOrganizer.swift
//
//	Create by David Buhauer on 19/9/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class WNOrganizer : NSObject, NSCoding, Mappable{

	var descriptionField : WNDescription?
	var facebook : String?
	var id : String?
	var logo : WNLogo?
	var logoId : String?
	var longDescription : WNDescription?
	var name : String?
	var numFutureEvents : Int?
	var numPastEvents : Int?
	var resourceUri : String?
	var url : String?


	class func newInstance(map: Map) -> Mappable?{
		return WNOrganizer()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		descriptionField <- map["description"]
		facebook <- map["facebook"]
		id <- map["id"]
		logo <- map["logo"]
		logoId <- map["logo_id"]
		longDescription <- map["long_description"]
		name <- map["name"]
		numFutureEvents <- map["num_future_events"]
		numPastEvents <- map["num_past_events"]
		resourceUri <- map["resource_uri"]
		url <- map["url"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         descriptionField = aDecoder.decodeObject(forKey: "description") as? WNDescription
         facebook = aDecoder.decodeObject(forKey: "facebook") as? String
         id = aDecoder.decodeObject(forKey: "id") as? String
         logo = aDecoder.decodeObject(forKey: "logo") as? WNLogo
         logoId = aDecoder.decodeObject(forKey: "logo_id") as? String
         longDescription = aDecoder.decodeObject(forKey: "long_description") as? WNDescription
         name = aDecoder.decodeObject(forKey: "name") as? String
         numFutureEvents = aDecoder.decodeObject(forKey: "num_future_events") as? Int
         numPastEvents = aDecoder.decodeObject(forKey: "num_past_events") as? Int
         resourceUri = aDecoder.decodeObject(forKey: "resource_uri") as? String
         url = aDecoder.decodeObject(forKey: "url") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "description")
		}
		if facebook != nil{
			aCoder.encode(facebook, forKey: "facebook")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if logo != nil{
			aCoder.encode(logo, forKey: "logo")
		}
		if logoId != nil{
			aCoder.encode(logoId, forKey: "logo_id")
		}
		if longDescription != nil{
			aCoder.encode(longDescription, forKey: "long_description")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if numFutureEvents != nil{
			aCoder.encode(numFutureEvents, forKey: "num_future_events")
		}
		if numPastEvents != nil{
			aCoder.encode(numPastEvents, forKey: "num_past_events")
		}
		if resourceUri != nil{
			aCoder.encode(resourceUri, forKey: "resource_uri")
		}
		if url != nil{
			aCoder.encode(url, forKey: "url")
		}

	}

}