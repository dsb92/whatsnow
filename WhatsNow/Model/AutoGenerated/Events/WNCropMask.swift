//
//	WNCropMask.swift
//
//	Create by David Buhauer on 19/9/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class WNCropMask : NSObject, NSCoding, Mappable{

	var height : Int?
	var topLeft : WNTopLeft?
	var width : Int?


	class func newInstance(map: Map) -> Mappable?{
		return WNCropMask()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		height <- map["height"]
		topLeft <- map["top_left"]
		width <- map["width"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         height = aDecoder.decodeObject(forKey: "height") as? Int
         topLeft = aDecoder.decodeObject(forKey: "top_left") as? WNTopLeft
         width = aDecoder.decodeObject(forKey: "width") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if height != nil{
			aCoder.encode(height, forKey: "height")
		}
		if topLeft != nil{
			aCoder.encode(topLeft, forKey: "top_left")
		}
		if width != nil{
			aCoder.encode(width, forKey: "width")
		}

	}

}