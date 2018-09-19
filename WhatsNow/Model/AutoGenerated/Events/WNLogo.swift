//
//	WNLogo.swift
//
//	Create by David Buhauer on 19/9/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class WNLogo : NSObject, NSCoding, Mappable{

	var aspectRatio : String?
	var cropMask : WNCropMask?
	var edgeColor : String?
	var edgeColorSet : Bool?
	var id : String?
	var original : WNOriginal?
	var url : String?

	class func newInstance(map: Map) -> Mappable?{
		return WNLogo()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		aspectRatio <- map["aspect_ratio"]
		cropMask <- map["crop_mask"]
		edgeColor <- map["edge_color"]
		edgeColorSet <- map["edge_color_set"]
		id <- map["id"]
		original <- map["original"]
		url <- map["url"]
		aspectRatio <- map["aspect_ratio"]
		cropMask <- map["crop_mask"]
		edgeColor <- map["edge_color"]
		edgeColorSet <- map["edge_color_set"]
		original <- map["original"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         aspectRatio = aDecoder.decodeObject(forKey: "aspect_ratio") as? String
         cropMask = aDecoder.decodeObject(forKey: "crop_mask") as? WNCropMask
         edgeColor = aDecoder.decodeObject(forKey: "edge_color") as? String
         edgeColorSet = aDecoder.decodeObject(forKey: "edge_color_set") as? Bool
         id = aDecoder.decodeObject(forKey: "id") as? String
         original = aDecoder.decodeObject(forKey: "original") as? WNOriginal
         url = aDecoder.decodeObject(forKey: "url") as? String
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if aspectRatio != nil{
			aCoder.encode(aspectRatio, forKey: "aspect_ratio")
		}
		if cropMask != nil{
			aCoder.encode(cropMask, forKey: "crop_mask")
		}
		if edgeColor != nil{
			aCoder.encode(edgeColor, forKey: "edge_color")
		}
		if edgeColorSet != nil{
			aCoder.encode(edgeColorSet, forKey: "edge_color_set")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if original != nil{
			aCoder.encode(original, forKey: "original")
		}
		if url != nil{
			aCoder.encode(url, forKey: "url")
		}
	}
}
