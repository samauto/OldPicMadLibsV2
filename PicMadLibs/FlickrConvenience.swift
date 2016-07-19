//
//  FlickrConvenience.swift
//  PicMadLibs
//
//  Created by Mac on 5/19/16.
//  Copyright © 2016 STDESIGN. All rights reserved.
//

import UIKit
import MapKit
import CoreData
import Foundation

// MARK: - FlickrAPI (Convenient Resource Methods)

extension FlickrAPI {
    
    //USER ENTERS NOUN = Text Parameter
    //
    
    // MARK: GET Convenience Methods
    
    // Get Flickr Photos
    func getPhotos(madlib: MadLib, word: String, type: String, completionHandlerForPhotos: (success: Bool, result: AnyObject!, errorString: String?) -> Void) {
        
        // Method Parameters
        let methodParameters: [String: String!] = [
            Constants.FlickrParameterKeys.Method: Constants.FlickrParameterValues.SearchMethod,
            Constants.FlickrParameterKeys.APIKey: Constants.FlickrParameterValues.APIKey,
            Constants.FlickrParameterKeys.SafeSearch: Constants.FlickrParameterValues.UseSafeSearch,
            Constants.FlickrParameterKeys.Extras: Constants.FlickrParameterValues.MediumURL,
            Constants.FlickrParameterKeys.OutputFormat: Constants.FlickrParameterValues.ResponseFormat,
            Constants.FlickrParameterKeys.NoJSONCallback: Constants.FlickrParameterValues.DisableJSONCallback,
            Constants.FlickrParameterKeys.PerPage: Constants.FlickrParameterValues.PicsPerPage,
            Constants.FlickrParameterKeys.Page: Constants.FlickrParameterValues.NumOfPages,
            Constants.FlickrParameterKeys.License: Constants.FlickrParameterValues.LicenseSearch,
            Constants.FlickrParameterKeys.Text: word
        ]
        
        //DEBUG: print (methodParameters)
        
        // Add numPages
        var withPageDictionary = methodParameters
        //withPageDictionary["page"] = String(pin.numPages)
        
        /* 2. Make the request */
        taskForGETMethod(withPageDictionary) { (success, results, error) in
            if let error = error {
                print ("JSON Error")
            } else {
                // GUARD: Did Flickr return an stat error of NOT OK
                guard let stat = results["stat"] as? String
                    where stat == "ok"
                    else {
                        print("Flickr API returned an error. See error code and message in \(results)")
                        
                        completionHandlerForPhotos(success: false, result: nil, errorString: "There was an error with the Flickr service.")
                        return
                }
                
                // GUARD: Is the "PHOTOS" keyword in our Parsed result?
                guard let photosDictionary = results["photos"] as? NSDictionary
                    else {
                        print("Cannot find keyword 'photos' in \(results)")
                        completionHandlerForPhotos(success: false, result: nil, errorString: "There was an error reading the photo data.")
                        return
                }
                
                
                // GUARD: Is the "TOTAL" key in photosDictionary? */
                guard let totalPhotos = (photosDictionary["total"] as? NSString)?.integerValue
                    else {
                        print("Cannot find key 'total' in \(photosDictionary)")
                        completionHandlerForPhotos(success: false, result: nil, errorString: "There was an error reading the photo data.")
                        return
                }
                
                // GUARD: Is the "PHOTO" key in photosDictionary? */
                guard let photoArray = photosDictionary["photo"] as? [[String: AnyObject]]
                    else {
                        print("Cannot find key 'photo' in \(photosDictionary)")
                        completionHandlerForPhotos(success: false, result: nil, errorString: "There was an error reading the photo data.")
                        return
                }
                
                if (photoArray.count == 0 && totalPhotos > 0){
                    completionHandlerForPhotos(success: false, result: nil, errorString: "There are no MORE photos for this location.")
                }
                else if (photoArray.count == 0 && totalPhotos == 0) {
                    completionHandlerForPhotos(success: false, result: nil, errorString: "There are NO photos for this location.")
                }
                else {
                    // Check Each Photo
                    for photo in photoArray {
                        // GUARD: Does our photo have a "URL_M"
                        guard let photoPath = photo["url_m"] as? String
                            else {
                                print("Cannot find key 'url_m' in \(photo)")
                                completionHandlerForPhotos(success: false, result: nil, errorString: "There was an error reading the photo data.")
                                return
                            }
                        //DEBUG: print ("PATH", photoPath)
                        
                        // GUARD: Does our photo have a "ID"
                        guard let photoName = photo["id"] as? String
                            else {
                                print("Cannot find key 'id' in \(photo)")
                                completionHandlerForPhotos(success: false, result: nil, errorString: "There was an error reading the photo data.")
                                return
                            }
                        
                        //DEBUG: print ("NAME", photoName)
                        
                        performOnMain {
                            print ("N=",photoName, "P=",photoPath)
                            //let photoObject = MadLib(madID: madlib.madlibID as String, noun:madlib.nouns as String, nName: photoName, nPath: photoPath, verb:madlib.verbs as String, adverb:madlib.adverbs as String, adjective:madlib.adjectives as String, context:  self.sharedContext)
                            if (type == "noun") {
                                let nounObject = NounPhoto(madlib: madlib, wName: photoName, wPath: photoPath, context:  self.sharedContext)
                                print("NOUNOBJECT")
                            } else if (type == "verb") {
                                let verbObject = VerbPhoto(madlib: madlib, wName: photoName, wPath: photoPath, context:  self.sharedContext)
                                print("VERBOBJECT")
                            }
                            else if (type == "adverb") {
                                let adverbObject = AdverbPhoto(madlib: madlib, wName: photoName, wPath: photoPath, context:  self.sharedContext)
                                print("ADVERBOBJECT")
                            }
                            else {
                                let adjectiveObject = AdjectivePhoto(madlib: madlib, wName: photoName, wPath: photoPath, context:  self.sharedContext)
                                print("ADJECTIVEOBJECT")
                            }
                            CoreDataStackManager.sharedInstance().saveContext()
                        }
                    }
                    completionHandlerForPhotos(success: true, result: nil, errorString: nil)
                }
            }
        }
        
    }//END OF FUNC: getPhotos
    
    
    // MARK: Helper Functions
    
    /* Set the box boundaries of the search for the pin location */
    func bboxString(pin: MKAnnotation) -> String {
        // ensure bbox is bounded by minimum and maximums
        
        let latitude = pin.coordinate.latitude
        let longitude = pin.coordinate.longitude
        
        /* |-------------------| */
        /* |    MAX LATITUDE   | */
        /* |                   | */
        /* |      LATITUDE     | */
        /* |                   | */
        /* |    MIN LATITUDE   | */
        /* |-------------------| */
        
        let max_lat = min(latitude + Constants.FlickrSearchParameters.SearchHeight, Constants.FlickrSearchParameters.SearchLatRange.1)
        let min_lat = max(latitude - Constants.FlickrSearchParameters.SearchHeight, Constants.FlickrSearchParameters.SearchLatRange.0)
        
        /* |---------------------| */
        /* |    MAX LONGITUDE    | */
        /* |                     | */
        /* |      LONGITUDE      | */
        /* |                     | */
        /* |    MIN LONGITUDE    | */
        /* |---------------------| */
        
        let max_long = min(longitude + Constants.FlickrSearchParameters.SearchWidth, Constants.FlickrSearchParameters.SearchLonRange.1)
        let min_long = max(longitude - Constants.FlickrSearchParameters.SearchWidth, Constants.FlickrSearchParameters.SearchLonRange.0)
        
        //print("BoundingBox", "\(min_long),\(min_lat),\(max_long),\(max_lat)")
        return "\(min_long),\(min_lat),\(max_long),\(max_lat)"
        
    }//END OF FUNC: bboxString
    
    
    // MARK: - Core Data Convenience
    
    var sharedContext: NSManagedObjectContext {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }
    
    
}//END OF EXTENSION: FlickrAPI


