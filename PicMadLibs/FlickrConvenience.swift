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
        
        /* 2. Make the request */
        taskForGETMethod(methodParameters) { (success, results, error) in
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
                        
                        // GUARD: Does our photo have a "ID"
                        guard let photoName = photo["id"] as? String
                            else {
                                print("Cannot find key 'id' in \(photo)")
                                completionHandlerForPhotos(success: false, result: nil, errorString: "There was an error reading the photo data.")
                                return
                            }
                        
                        var wordData = NSData()
                        
                            let wordPhotoData = self.taskForPhoto(photoPath) { (success, imageData, error) in
                                if (success == false) {
                                } else {
                                    wordData = imageData!
                                }
                                
                                if (type == "noun") {
                                    let nounObject = NounPhoto(madlib: madlib, wName: photoName, wPath: photoPath, wData: wordData, context: self.sharedContext)
                                } else if (type == "verb") {
                                    let verbObject = VerbPhoto(madlib: madlib, wName: photoName, wPath: photoPath, wData: wordData, context: self.sharedContext)
                                } else if (type == "adverb") {
                                    let adverbObject = AdverbPhoto(madlib: madlib, wName: photoName, wPath: photoPath, wData: wordData, context: self.sharedContext)
                                } else {
                                    let adjectiveObject = AdjectivePhoto(madlib: madlib, wName: photoName, wPath: photoPath, wData: wordData, context: self.sharedContext)
                                }
                            }

                            CoreDataStackManager.sharedInstance().saveContext()

                    }
                    completionHandlerForPhotos(success: true, result: nil, errorString: nil)
                }
            }
        }
        
    }
    //END OF FUNC: getPhotos

    
    // MARK: - Core Data Convenience
    
    var sharedContext: NSManagedObjectContext {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }
    
}
//END OF EXTENSION: FlickrAPI


