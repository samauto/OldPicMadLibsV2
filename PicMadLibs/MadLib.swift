//
//  MadLib.swift
//  PicMadLibs
//
//  Created by Mac on 5/18/16.
//  Copyright © 2016 STDESIGN. All rights reserved.
//

import Foundation
import UIKit

//1. Import Core Data
import CoreData


//2. Make Madlib a subclass of NSManagedObject
class MadLib: NSManagedObject {
        

    
    let imageCache = ImageCache()
    
    // MARK: Core Data
    // MARK: Init
    
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        //Standard Core Data init method
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        
    }//END OF INIT
    
    
    init(madID: String, noun: String, verb: String, adverb: String, adjective: String, context: NSManagedObjectContext) {
        
        // Core Data
        
        let entity =  NSEntityDescription.entityForName("MadLib", inManagedObjectContext: context)!
        super.init(entity: entity,insertIntoManagedObjectContext: context)
        
        // Initialize stored properties
        madlibID = madID
        nouns = noun
        verbs = verb
        adverbs = adverb
        adjectives = adjective
        
        timeStamp = NSDate()
        
    }//END OF INIT
    



    //MARK: Photos
 /*
    func deleteNounPhotos() {
        
        for noun in nouns {
            deleteNoun(noun)
        }
    }//END OF FUNC: deleteNounPhotos
    
    func deleteVerbPhotos() {
        
        for verb in verbs {
            deleteVerb(verb)
        }
    }//END OF FUNC: deleteVerbPhotos

    func deleteAdverbPhotos() {
        
        for adverb in adverbs {
            deleteAdverb(adverb)
        }
    }//END OF FUNC: deleteNounPhotos
    
    func deleteAdjectivePhotos() {
        
        for adjective in adjectives {
            deleteAdjective(adjective)
        }
    }//END OF FUNC: deleteVerbPhotos
    
    func deleteAllPhotos() {
        
        deleteNounPhotos()
        deleteVerbPhotos()
        deleteAdverbPhotos()
        deleteAdjectivePhotos()
        
    }//END OF FUNC: deleteNounPhotos
    
    
    func deleteNoun(noun: Noun) {
        /* Delete the photo (including image data from the cache and hard drive) */
        imageCache.deleteImage(noun.nounName)
        sharedContext.deleteObject(noun)
        
        CoreDataStackManager.sharedInstance().saveContext()
    }
    
    func deleteVerb(verb: Verb) {
        /* Delete the photo (including image data from the cache and hard drive) */
        imageCache.deleteImage(verb.verbName)
        sharedContext.deleteObject(verb)
        
        CoreDataStackManager.sharedInstance().saveContext()
    }
    
    func deleteAdverb(adverb: Adverb) {
        /* Delete the photo (including image data from the cache and hard drive) */
        imageCache.deleteImage(adverb.adverbName)
        sharedContext.deleteObject(adverb)
        
        CoreDataStackManager.sharedInstance().saveContext()
    }
    
    func deleteAdjective(adjective: Adjective) {
        /* Delete the photo (including image data from the cache and hard drive) */
        imageCache.deleteImage(adjective.adjectiveName)
        sharedContext.deleteObject(adjective)
        
        CoreDataStackManager.sharedInstance().saveContext()
    }
    
    
   // func deleteSelectedPhotos(selectedPhotos: [Photo]) {
   //     for photo in selectedPhotos {
   //         deletePhoto(photo)
   //     }
   // }
    
    
    // MARK: - Core Data Convenience
    
    var sharedContext: NSManagedObjectContext {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }
    
    
*/
    
} //END OF CLASS: Pin
