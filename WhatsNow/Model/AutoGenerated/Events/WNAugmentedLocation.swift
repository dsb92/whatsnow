//
//	WNAugmentedLocation.swift
//
//	Create by David Buhauer on 19/9/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class WNAugmentedLocation : NSObject, NSCoding, Mappable{

	var city : String?
	var country : String?


	class func newInstance(map: Map) -> Mappable?{
		return WNAugmentedLocation()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		city <- map["city"]
		country <- map["country"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         city = aDecoder.decodeObject(forKey: "city") as? String
         country = aDecoder.decodeObject(forKey: "country") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if city != nil{
			aCoder.encode(city, forKey: "city")
		}
		if country != nil{
			aCoder.encode(country, forKey: "country")
		}

	}

}