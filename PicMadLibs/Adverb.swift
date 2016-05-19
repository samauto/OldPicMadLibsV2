//
//  Adverb.swift
//  PicMadLibs
//
//  Created by Mac on 5/18/16.
//  Copyright © 2016 STDESIGN. All rights reserved.
//

import CoreData
import UIKit

class Adverb: NSManagedObject {
    
    // MARK: PROPERTIES
    @NSManaged var adverbName: String
    @NSManaged var adverbPath: String
    @NSManaged var madlib: MadLib
    
    
    // MARK: CoreData
    
    //Standard Core Data init method
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        
    }//END OF INIT
    
    
    // Init photo
    init(madlib: MadLib, name: String, path: String, context: NSManagedObjectContext) {
        
        // Core Data
        let entity =  NSEntityDescription.entityForName("Photo", inManagedObjectContext: context)!
        super.init(entity: entity,insertIntoManagedObjectContext: context)
        
        // Initialize stored properties
        self.adverbName = name
        self.madlib = madlib
        self.adverbPath =  path
        
    }//END OF INIT
    
    
    // MARK: Image
    var photoAdverbImage:UIImage? {
        
        // Getting and setting filename as URL's last component
        get {
            return FlickrAPI.Caches.imageCache.imageWithIdentifier(adverbName)
        }
        
        set {
            FlickrAPI.Caches.imageCache.storeImage(newValue, withIdentifier: adverbName)
        }
    }//END OF VAR: photoAdverbImage
    
}//END OF CLASS: Adverb

