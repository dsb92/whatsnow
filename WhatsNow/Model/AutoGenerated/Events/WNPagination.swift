//
//	WNPagination.swift
//
//	Create by David Buhauer on 19/9/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class WNPagination : NSObject, NSCoding, Mappable{

	var hasMoreItems : Bool?
	var objectCount : Int?
	var pageCount : Int?
	var pageNumber : Int?
	var pageSize : Int?


	class func newInstance(map: Map) -> Mappable?{
		return WNPagination()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		hasMoreItems <- map["has_more_items"]
		objectCount <- map["object_count"]
		pageCount <- map["page_count"]
		pageNumber <- map["page_number"]
		pageSize <- map["page_size"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         hasMoreItems = aDecoder.decodeObject(forKey: "has_more_items") as? Bool
         objectCount = aDecoder.decodeObject(forKey: "object_count") as? Int
         pageCount = aDecoder.decodeObject(forKey: "page_count") as? Int
         pageNumber = aDecoder.decodeObject(forKey: "page_number") as? Int
         pageSize = aDecoder.decodeObject(forKey: "page_size") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if hasMoreItems != nil{
			aCoder.encode(hasMoreItems, forKey: "has_more_items")
		}
		if objectCount != nil{
			aCoder.encode(objectCount, forKey: "object_count")
		}
		if pageCount != nil{
			aCoder.encode(pageCount, forKey: "page_count")
		}
		if pageNumber != nil{
			aCoder.encode(pageNumber, forKey: "page_number")
		}
		if pageSize != nil{
			aCoder.encode(pageSize, forKey: "page_size")
		}

	}

}