//
//  findPhotosAPI.swift
//  PicMadLibs
//
//  Created by Mac on 7/23/16.
//  Copyright © 2016 STDESIGN. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension PML_FormController{
    
    //MARK: FIND PHOTOS

    func findPhotos(madlib: MadLib, noun: String, verb: String, adverb: String, adjective: String) {
    
        FlickrAPI.sharedInstance().getPhotos(madlib, word: noun, type: "noun") { (success, results, errorString) in
            if success == false {
                performOnMain {
                    self.popAlert("ERROR", errorString: "Error can't find find Photos via Flickr")
                }
            }
        }
    
        FlickrAPI.sharedInstance().getPhotos(madlib, word: verb, type: "verb") { (success, results, errorString) in
            if success == false {
                performOnMain {
                    self.popAlert("ERROR", errorString: "Error can't find find Photos via Flickr")
                }
            }
        }
    
        FlickrAPI.sharedInstance().getPhotos(madlib, word: adverb, type: "adverb") { (success, results, errorString) in
            if success == false {
                performOnMain {
                    self.popAlert("ERROR", errorString: "Error can't find find Photos via Flickr")
                }
            }
        }
    
        FlickrAPI.sharedInstance().getPhotos(madlib, word: adjective, type: "adjective") { (success, results, errorString) in
            if success == false {
                performOnMain {
                    self.popAlert("ERROR", errorString: "Error can't find find Photos via Flickr")
                }
            }
        }
    
    }
    //END OF FUNC: findPhotos

}
//END OF EXTENSION: findPhotosAPI
