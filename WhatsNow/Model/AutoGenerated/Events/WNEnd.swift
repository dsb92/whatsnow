//
//	WNEnd.swift
//
//	Create by David Buhauer on 19/9/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class WNEnd : NSObject, NSCoding, Mappable{

	var local : String?
	var timezone : String?
	var utc : String?


	class func newInstance(map: Map) -> Mappable?{
		return WNEnd()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		local <- map["local"]
		timezone <- map["timezone"]
		utc <- map["utc"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         local = aDecoder.decodeObject(forKey: "local") as? String
         timezone = aDecoder.decodeObject(forKey: "timezone") as? String
         utc = aDecoder.decodeObject(forKey: "utc") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if local != nil{
			aCoder.encode(local, forKey: "local")
		}
		if timezone != nil{
			aCoder.encode(timezone, forKey: "timezone")
		}
		if utc != nil{
			aCoder.encode(utc, forKey: "utc")
		}

	}

}