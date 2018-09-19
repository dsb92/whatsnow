//
//	WNLocation.swift
//
//	Create by David Buhauer on 19/9/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class WNLocation : NSObject, NSCoding, Mappable{

	var address : String?
	var augmentedLocation : WNAugmentedLocation?
	var latitude : String?
	var longitude : String?
	var within : String?


	class func newInstance(map: Map) -> Mappable?{
		return WNLocation()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		address <- map["address"]
		augmentedLocation <- map["augmented_location"]
		latitude <- map["latitude"]
		longitude <- map["longitude"]
		within <- map["within"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         address = aDecoder.decodeObject(forKey: "address") as? String
         augmentedLocation = aDecoder.decodeObject(forKey: "augmented_location") as? WNAugmentedLocation
         latitude = aDecoder.decodeObject(forKey: "latitude") as? String
         longitude = aDecoder.decodeObject(forKey: "longitude") as? String
         within = aDecoder.decodeObject(forKey: "within") as? String

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
		if augmentedLocation != nil{
			aCoder.encode(augmentedLocation, forKey: "augmented_location")
		}
		if latitude != nil{
			aCoder.encode(latitude, forKey: "latitude")
		}
		if longitude != nil{
			aCoder.encode(longitude, forKey: "longitude")
		}
		if within != nil{
			aCoder.encode(within, forKey: "within")
		}

	}

}