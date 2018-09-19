//
//	WNAddres.swift
//
//	Create by David Buhauer on 19/9/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class WNAddres : NSObject, NSCoding, Mappable{

	var address1 : String?
	var address2 : AnyObject?
	var city : String?
	var country : String?
	var latitude : String?
	var localizedAddressDisplay : String?
	var localizedAreaDisplay : String?
	var localizedMultiLineAddressDisplay : [String]?
	var longitude : String?
	var postalCode : String?
	var region : AnyObject?


	class func newInstance(map: Map) -> Mappable?{
		return WNAddres()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		address1 <- map["address_1"]
		address2 <- map["address_2"]
		city <- map["city"]
		country <- map["country"]
		latitude <- map["latitude"]
		localizedAddressDisplay <- map["localized_address_display"]
		localizedAreaDisplay <- map["localized_area_display"]
		localizedMultiLineAddressDisplay <- map["localized_multi_line_address_display"]
		longitude <- map["longitude"]
		postalCode <- map["postal_code"]
		region <- map["region"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         address1 = aDecoder.decodeObject(forKey: "address_1") as? String
         address2 = aDecoder.decodeObject(forKey: "address_2") as? AnyObject
         city = aDecoder.decodeObject(forKey: "city") as? String
         country = aDecoder.decodeObject(forKey: "country") as? String
         latitude = aDecoder.decodeObject(forKey: "latitude") as? String
         localizedAddressDisplay = aDecoder.decodeObject(forKey: "localized_address_display") as? String
         localizedAreaDisplay = aDecoder.decodeObject(forKey: "localized_area_display") as? String
         localizedMultiLineAddressDisplay = aDecoder.decodeObject(forKey: "localized_multi_line_address_display") as? [String]
         longitude = aDecoder.decodeObject(forKey: "longitude") as? String
         postalCode = aDecoder.decodeObject(forKey: "postal_code") as? String
         region = aDecoder.decodeObject(forKey: "region") as? AnyObject

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if address1 != nil{
			aCoder.encode(address1, forKey: "address_1")
		}
		if address2 != nil{
			aCoder.encode(address2, forKey: "address_2")
		}
		if city != nil{
			aCoder.encode(city, forKey: "city")
		}
		if country != nil{
			aCoder.encode(country, forKey: "country")
		}
		if latitude != nil{
			aCoder.encode(latitude, forKey: "latitude")
		}
		if localizedAddressDisplay != nil{
			aCoder.encode(localizedAddressDisplay, forKey: "localized_address_display")
		}
		if localizedAreaDisplay != nil{
			aCoder.encode(localizedAreaDisplay, forKey: "localized_area_display")
		}
		if localizedMultiLineAddressDisplay != nil{
			aCoder.encode(localizedMultiLineAddressDisplay, forKey: "localized_multi_line_address_display")
		}
		if longitude != nil{
			aCoder.encode(longitude, forKey: "longitude")
		}
		if postalCode != nil{
			aCoder.encode(postalCode, forKey: "postal_code")
		}
		if region != nil{
			aCoder.encode(region, forKey: "region")
		}

	}

}