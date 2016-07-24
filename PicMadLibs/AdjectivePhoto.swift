//
//  AdjectivePhoto.swift
//  PicMadLibs
//
//  Created by Mac on 5/18/16.
//  Copyright © 2016 STDESIGN. All rights reserved.
//

import CoreData
import UIKit

class AdjectivePhoto: NSManagedObject {
    
    // MARK: PROPERTIES
    @NSManaged var wordName:String?
    @NSManaged var wordPath: String?
    @NSManaged var imageData: NSData?
    @NSManaged var id: NSNumber?
    @NSManaged var madlib: MadLib?
    @NSManaged var fullRes: NSManagedObject?
    
    
    // MARK: CoreData
    
    //Standard Core Data init method
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        
    }//END OF INIT
    
    
    // Init photo
    init(madlib: MadLib, wName: String, wPath: String, wData: NSData,   context: NSManagedObjectContext) {
        
        // Core Data
        let entity =  NSEntityDescription.entityForName("AdjectivePhoto", inManagedObjectContext: context)!
        super.init(entity: entity,insertIntoManagedObjectContext: context)
        
        // Initialize stored properties
        self.wordName = wName
        self.wordPath =  wPath
        self.imageData = wData
        self.madlib = madlib
        
    }//END OF INIT
    
    
    // MARK: Image
    var photoWordImage:UIImage? {
        
        // Getting and setting filename as URL's last component
        get {
            return FlickrAPI.Caches.imageCache.imageWithIdentifier(wordName)
        }
        
        set {
            FlickrAPI.Caches.imageCache.storeImage(newValue, withIdentifier: wordName!)
        }
    }//END OF VAR: photoWordImage
    
}//END OF CLASS: Adjective

