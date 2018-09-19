//
//	WNOriginal.swift
//
//	Create by David Buhauer on 19/9/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class WNOriginal : NSObject, NSCoding, Mappable{

	var height : Int?
	var url : String?
	var width : Int?


	class func newInstance(map: Map) -> Mappable?{
		return WNOriginal()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		height <- map["height"]
		url <- map["url"]
		width <- map["width"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         height = aDecoder.decodeObject(forKey: "height") as? Int
         url = aDecoder.decodeObject(forKey: "url") as? String
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
		if url != nil{
			aCoder.encode(url, forKey: "url")
		}
		if width != nil{
			aCoder.encode(width, forKey: "width")
		}

	}

}