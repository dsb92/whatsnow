//
//	WNVenue.swift
//
//	Create by David Buhauer on 19/9/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class WNVenue : NSObject, NSCoding, Mappable{

	var address : WNAddres?
	var ageRestriction : AnyObject?
	var capacity : AnyObject?
	var id : String?
	var latitude : String?
	var longitude : String?
	var name : String?
	var resourceUri : String?


	class func newInstance(map: Map) -> Mappable?{
		return WNVenue()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		address <- map["address"]
		ageRestriction <- map["age_restriction"]
		capacity <- map["capacity"]
		id <- map["id"]
		latitude <- map["latitude"]
		longitude <- map["longitude"]
		name <- map["name"]
		resourceUri <- map["resource_uri"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         address = aDecoder.decodeObject(forKey: "address") as? WNAddres
         ageRestriction = aDecoder.decodeObject(forKey: "age_restriction") as? AnyObject
         capacity = aDecoder.decodeObject(forKey: "capacity") as? AnyObject
         id = aDecoder.decodeObject(forKey: "id") as? String
         latitude = aDecoder.decodeObject(forKey: "latitude") as? String
         longitude = aDecoder.decodeObject(forKey: "longitude") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         resourceUri = aDecoder.decodeObject(forKey: "resource_uri") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if address != nil{
			aCoder.encode(address, forKey: "address")
		}
		if ageRestriction != nil{
			aCoder.encode(ageRestriction, forKey: "age_restriction")
		}
		if capacity != nil{
			aCoder.encode(capacity, forKey: "capacity")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if latitude != nil{
			aCoder.encode(latitude, forKey: "latitude")
		}
		if longitude != nil{
			aCoder.encode(longitude, forKey: "longitude")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if resourceUri != nil{
			aCoder.encode(resourceUri, forKey: "resource_uri")
		}

	}

}