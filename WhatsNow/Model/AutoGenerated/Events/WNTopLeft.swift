//
//	WNTopLeft.swift
//
//	Create by David Buhauer on 19/9/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class WNTopLeft : NSObject, NSCoding, Mappable{

	var x : Int?
	var y : Int?


	class func newInstance(map: Map) -> Mappable?{
		return WNTopLeft()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		x <- map["x"]
		y <- map["y"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         x = aDecoder.decodeObject(forKey: "x") as? Int
         y = aDecoder.decodeObject(forKey: "y") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if x != nil{
			aCoder.encode(x, forKey: "x")
		}
		if y != nil{
			aCoder.encode(y, forKey: "y")
		}

	}

}