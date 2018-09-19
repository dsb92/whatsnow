//
//	WNLogoParser.swift
//
//	Create by David Buhauer on 16/9/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class WNLogoParser : NSObject, NSCoding, Mappable{

	var logo : WNLogo?


	class func newInstance(map: Map) -> Mappable?{
		return WNLogoParser()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		logo <- map["logo"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         logo = aDecoder.decodeObject(forKey: "logo") as? WNLogo

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if logo != nil{
			aCoder.encode(logo, forKey: "logo")
		}

	}

}