//
//	WNEvent.swift
//
//	Create by David Buhauer on 19/9/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class WNEvent : NSObject, NSCoding, Mappable{

	var capacity : AnyObject?
	var capacityIsCustom : AnyObject?
	var categoryId : String?
	var changed : String?
	var created : String?
	var currency : String?
	var descriptionField : WNDescription?
	var end : WNEnd?
	var formatId : String?
	var hideEndDate : Bool?
	var hideStartDate : Bool?
	var id : String?
	var isExternallyTicketed : Bool?
	var isFree : Bool?
	var isLocked : Bool?
	var isReservedSeating : Bool?
	var isSeries : Bool?
	var isSeriesParent : Bool?
	var listed : Bool?
	var locale : String?
	var logo : WNLogo?
	var logoId : String?
	var name : WNDescription?
	var onlineEvent : Bool?
	var organizationId : String?
	var organizer : WNOrganizer?
	var organizerId : String?
	var privacySetting : String?
	var resourceUri : String?
	var seriesId : String?
	var shareable : Bool?
	var showColorsInSeatmapThumbnail : Bool?
	var showPickASeat : Bool?
	var showSeatmapThumbnail : Bool?
	var source : String?
	var start : WNEnd?
	var status : String?
	var subcategoryId : AnyObject?
	var txTimeLimit : Int?
	var url : String?
	var vanityUrl : String?
	var venue : WNVenue?
	var venueId : String?
	var version : String?


	class func newInstance(map: Map) -> Mappable?{
		return WNEvent()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		capacity <- map["capacity"]
		capacityIsCustom <- map["capacity_is_custom"]
		categoryId <- map["category_id"]
		changed <- map["changed"]
		created <- map["created"]
		currency <- map["currency"]
		descriptionField <- map["description"]
		end <- map["end"]
		formatId <- map["format_id"]
		hideEndDate <- map["hide_end_date"]
		hideStartDate <- map["hide_start_date"]
		id <- map["id"]
		isExternallyTicketed <- map["is_externally_ticketed"]
		isFree <- map["is_free"]
		isLocked <- map["is_locked"]
		isReservedSeating <- map["is_reserved_seating"]
		isSeries <- map["is_series"]
		isSeriesParent <- map["is_series_parent"]
		listed <- map["listed"]
		locale <- map["locale"]
		logo <- map["logo"]
		logoId <- map["logo_id"]
		name <- map["name"]
		onlineEvent <- map["online_event"]
		organizationId <- map["organization_id"]
		organizer <- map["organizer"]
		organizerId <- map["organizer_id"]
		privacySetting <- map["privacy_setting"]
		resourceUri <- map["resource_uri"]
		seriesId <- map["series_id"]
		shareable <- map["shareable"]
		showColorsInSeatmapThumbnail <- map["show_colors_in_seatmap_thumbnail"]
		showPickASeat <- map["show_pick_a_seat"]
		showSeatmapThumbnail <- map["show_seatmap_thumbnail"]
		source <- map["source"]
		start <- map["start"]
		status <- map["status"]
		subcategoryId <- map["subcategory_id"]
		txTimeLimit <- map["tx_time_limit"]
		url <- map["url"]
		vanityUrl <- map["vanity_url"]
		venue <- map["venue"]
		venueId <- map["venue_id"]
		version <- map["version"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         capacity = aDecoder.decodeObject(forKey: "capacity") as? AnyObject
         capacityIsCustom = aDecoder.decodeObject(forKey: "capacity_is_custom") as? AnyObject
         categoryId = aDecoder.decodeObject(forKey: "category_id") as? String
         changed = aDecoder.decodeObject(forKey: "changed") as? String
         created = aDecoder.decodeObject(forKey: "created") as? String
         currency = aDecoder.decodeObject(forKey: "currency") as? String
         descriptionField = aDecoder.decodeObject(forKey: "description") as? WNDescription
         end = aDecoder.decodeObject(forKey: "end") as? WNEnd
         formatId = aDecoder.decodeObject(forKey: "format_id") as? String
         hideEndDate = aDecoder.decodeObject(forKey: "hide_end_date") as? Bool
         hideStartDate = aDecoder.decodeObject(forKey: "hide_start_date") as? Bool
         id = aDecoder.decodeObject(forKey: "id") as? String
         isExternallyTicketed = aDecoder.decodeObject(forKey: "is_externally_ticketed") as? Bool
         isFree = aDecoder.decodeObject(forKey: "is_free") as? Bool
         isLocked = aDecoder.decodeObject(forKey: "is_locked") as? Bool
         isReservedSeating = aDecoder.decodeObject(forKey: "is_reserved_seating") as? Bool
         isSeries = aDecoder.decodeObject(forKey: "is_series") as? Bool
         isSeriesParent = aDecoder.decodeObject(forKey: "is_series_parent") as? Bool
         listed = aDecoder.decodeObject(forKey: "listed") as? Bool
         locale = aDecoder.decodeObject(forKey: "locale") as? String
         logo = aDecoder.decodeObject(forKey: "logo") as? WNLogo
         logoId = aDecoder.decodeObject(forKey: "logo_id") as? String
         name = aDecoder.decodeObject(forKey: "name") as? WNDescription
         onlineEvent = aDecoder.decodeObject(forKey: "online_event") as? Bool
         organizationId = aDecoder.decodeObject(forKey: "organization_id") as? String
         organizer = aDecoder.decodeObject(forKey: "organizer") as? WNOrganizer
         organizerId = aDecoder.decodeObject(forKey: "organizer_id") as? String
         privacySetting = aDecoder.decodeObject(forKey: "privacy_setting") as? String
         resourceUri = aDecoder.decodeObject(forKey: "resource_uri") as? String
         seriesId = aDecoder.decodeObject(forKey: "series_id") as? String
         shareable = aDecoder.decodeObject(forKey: "shareable") as? Bool
         showColorsInSeatmapThumbnail = aDecoder.decodeObject(forKey: "show_colors_in_seatmap_thumbnail") as? Bool
         showPickASeat = aDecoder.decodeObject(forKey: "show_pick_a_seat") as? Bool
         showSeatmapThumbnail = aDecoder.decodeObject(forKey: "show_seatmap_thumbnail") as? Bool
         source = aDecoder.decodeObject(forKey: "source") as? String
         start = aDecoder.decodeObject(forKey: "start") as? WNEnd
         status = aDecoder.decodeObject(forKey: "status") as? String
         subcategoryId = aDecoder.decodeObject(forKey: "subcategory_id") as? AnyObject
         txTimeLimit = aDecoder.decodeObject(forKey: "tx_time_limit") as? Int
         url = aDecoder.decodeObject(forKey: "url") as? String
         vanityUrl = aDecoder.decodeObject(forKey: "vanity_url") as? String
         venue = aDecoder.decodeObject(forKey: "venue") as? WNVenue
         venueId = aDecoder.decodeObject(forKey: "venue_id") as? String
         version = aDecoder.decodeObject(forKey: "version") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if capacity != nil{
			aCoder.encode(capacity, forKey: "capacity")
		}
		if capacityIsCustom != nil{
			aCoder.encode(capacityIsCustom, forKey: "capacity_is_custom")
		}
		if categoryId != nil{
			aCoder.encode(categoryId, forKey: "category_id")
		}
		if changed != nil{
			aCoder.encode(changed, forKey: "changed")
		}
		if created != nil{
			aCoder.encode(created, forKey: "created")
		}
		if currency != nil{
			aCoder.encode(currency, forKey: "currency")
		}
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "description")
		}
		if end != nil{
			aCoder.encode(end, forKey: "end")
		}
		if formatId != nil{
			aCoder.encode(formatId, forKey: "format_id")
		}
		if hideEndDate != nil{
			aCoder.encode(hideEndDate, forKey: "hide_end_date")
		}
		if hideStartDate != nil{
			aCoder.encode(hideStartDate, forKey: "hide_start_date")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if isExternallyTicketed != nil{
			aCoder.encode(isExternallyTicketed, forKey: "is_externally_ticketed")
		}
		if isFree != nil{
			aCoder.encode(isFree, forKey: "is_free")
		}
		if isLocked != nil{
			aCoder.encode(isLocked, forKey: "is_locked")
		}
		if isReservedSeating != nil{
			aCoder.encode(isReservedSeating, forKey: "is_reserved_seating")
		}
		if isSeries != nil{
			aCoder.encode(isSeries, forKey: "is_series")
		}
		if isSeriesParent != nil{
			aCoder.encode(isSeriesParent, forKey: "is_series_parent")
		}
		if listed != nil{
			aCoder.encode(listed, forKey: "listed")
		}
		if locale != nil{
			aCoder.encode(locale, forKey: "locale")
		}
		if logo != nil{
			aCoder.encode(logo, forKey: "logo")
		}
		if logoId != nil{
			aCoder.encode(logoId, forKey: "logo_id")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if onlineEvent != nil{
			aCoder.encode(onlineEvent, forKey: "online_event")
		}
		if organizationId != nil{
			aCoder.encode(organizationId, forKey: "organization_id")
		}
		if organizer != nil{
			aCoder.encode(organizer, forKey: "organizer")
		}
		if organizerId != nil{
			aCoder.encode(organizerId, forKey: "organizer_id")
		}
		if privacySetting != nil{
			aCoder.encode(privacySetting, forKey: "privacy_setting")
		}
		if resourceUri != nil{
			aCoder.encode(resourceUri, forKey: "resource_uri")
		}
		if seriesId != nil{
			aCoder.encode(seriesId, forKey: "series_id")
		}
		if shareable != nil{
			aCoder.encode(shareable, forKey: "shareable")
		}
		if showColorsInSeatmapThumbnail != nil{
			aCoder.encode(showColorsInSeatmapThumbnail, forKey: "show_colors_in_seatmap_thumbnail")
		}
		if showPickASeat != nil{
			aCoder.encode(showPickASeat, forKey: "show_pick_a_seat")
		}
		if showSeatmapThumbnail != nil{
			aCoder.encode(showSeatmapThumbnail, forKey: "show_seatmap_thumbnail")
		}
		if source != nil{
			aCoder.encode(source, forKey: "source")
		}
		if start != nil{
			aCoder.encode(start, forKey: "start")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if subcategoryId != nil{
			aCoder.encode(subcategoryId, forKey: "subcategory_id")
		}
		if txTimeLimit != nil{
			aCoder.encode(txTimeLimit, forKey: "tx_time_limit")
		}
		if url != nil{
			aCoder.encode(url, forKey: "url")
		}
		if vanityUrl != nil{
			aCoder.encode(vanityUrl, forKey: "vanity_url")
		}
		if venue != nil{
			aCoder.encode(venue, forKey: "venue")
		}
		if venueId != nil{
			aCoder.encode(venueId, forKey: "venue_id")
		}
		if version != nil{
			aCoder.encode(version, forKey: "version")
		}

	}

}