//
//  FlickrConstant.swift
//  PicMadLibs
//
//  Created by Mac on 5/19/16.
//  Copyright © 2016 STDESIGN. All rights reserved.
//

import Foundation

import UIKit

// MARK: Flickr Constants

struct Constants {
    
    // MARK: Basic Constants URL
    struct FlickrBasicURL {
        static let APIScheme = "https"
        static let APIHost = "api.flickr.com"
        static let APIPath = "/services/rest"
        
        static let FlickrPhotosDataURL = APIScheme+"://"+APIHost+APIPath
        
    }//END OF STRUCT: Basic Constants URL
    
    
    // MARK: Search Parameters
    struct FlickrSearchParameters {
        //Box
        static let BOUNDING_BOX_HALF_WIDTH = 1.0
        static let BOUNDING_BOX_HALF_HEIGHT = 1.0
        
        static let SearchWidth = BOUNDING_BOX_HALF_WIDTH
        static let SearchHeight = BOUNDING_BOX_HALF_HEIGHT
        
        //Range
        static let LAT_MIN = -90.0
        static let LAT_MAX = 90.0
        
        static let LONG_MIN = -180.0
        static let LONG_MAX = 180.0
        
        static let SearchLatRange = (LAT_MIN, LAT_MAX)
        static let SearchLonRange = (LONG_MIN, LONG_MAX)
        
    }//END OF STRUCT: FlickrSearchParameters
    
    
    // MARK: Parameter Keys
    struct FlickrParameterKeys {
        //REQUIRED
        static let APIKey = "api_key"

        //OPTIONAL
        static let UserID = "user_id"
        static let Tags = "tags"
        static let TagMode = "tag_mode"
        static let Text = "text"
        static let MinUploadDate = "min_upload_date"
        static let MaxUploadDate = "max_upload_date"
        static let MinTakenDate = "min_taken_date"
        static let MaxTakenDate = "max_taken_date"
        static let License = "license"
        static let Sort = "sort"
        static let PrivacyFilter = "privacy_filter"
        static let BoundingBox = "bbox"
        static let Accuracy = "bbox"
        static let SafeSearch = "safe_search"
        static let ContentType = "content_type"
        static let MachineTags = "machine_tags"
        static let MachineTagMode = "machine_tag_mode"
        static let GroupID = "group_id"
        static let Contacts = "contacts"
        static let WoeID = "woe_id"
        static let PlaceID = "place_id"
        static let Media = "media"
        static let HadGeo = "has_geo"
        static let GeoContext = "geo_context"
        static let Lat = "lat"
        static let Lon = "lon"
        static let Radius = "radius"
        static let Radius_units = "radius_units"
        static let IsCommons = "is_commons"
        static let InGallery = "in_gallery"
        static let Extras = "extras"
        static let PerPage = "per_page"
        static let Page = "page"
        
        //Output
        static let Method = "method"
        static let OutputFormat = "format"
        static let NoJSONCallback = "nojsoncallback"
        
    }//END OF STRUCT: Parameter Keys
    
    
    // MARK: Parameter Values
    struct FlickrParameterValues {
        
        // Method
        static let SearchMethod = "flickr.photos.search"
        
        // APIKey
        static let APIKey = "fe87322b13a9c07a1a6d924e1570c4af"
        
        // OutputFormat
        static let ResponseFormat = "json"
        
        // NoJSONCallBack
        static let DisableJSONCallback = "1" /* 1 means "yes" */
        
        // SafeSearch
        static let UseSafeSearch = "1" /* 1 means "SAFE" */
        
        // License
        static let LicenseSearch = "6,7"
        /* 6 means Commeri */
        /* 7 means No known copyright restrictions */
        
        // Extras
        static let MediumURL = "url_m"
        
        // PerPage
        static let PicsPerPage = "4"
        
        // Page
        static let NumOfPages = "2"
        
    }//END OF STRUCT: Parameter Values
    
    
    // MARK: Response Keys
    struct FlickrResponseKeys {
        static let Status = "stat"
        static let Photos = "photos"
        static let Photo = "photo"
        static let Title = "title"
        static let MediumURL = "url_m"
        static let Pages = "pages"
        static let Total = "total"
        
    }//END OF STRUCT: Response Keys
    

    // MARK: Response Values
    struct FlickrResponseValues {

        // STATUS
        static let OKStatus = "ok"
        
    }//END OF STRUCT: Response Values
    
}//END OF STRUCT: Constants