//
//	WNDescription.swift
//
//	Create by David Buhauer on 19/9/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class WNDescription : NSObject, NSCoding, Mappable{

	var html : String?
	var text : String?


	class func newInstance(map: Map) -> Mappable?{
		return WNDescription()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		html <- map["html"]
		text <- map["text"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         html = aDecoder.decodeObject(forKey: "html") as? String
         text = aDecoder.decodeObject(forKey: "text") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if html != nil{
			aCoder.encode(html, forKey: "html")
		}
		if text != nil{
			aCoder.encode(text, forKey: "text")
		}

	}

}