//
//  NounPhoto+CoreDataProperties.swift
//  PicMadLibs
//
//  Created by Mac on 7/23/16.
//  Copyright © 2016 STDESIGN. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension NounPhoto {
    
    // MARK: PROPERTIES
    @NSManaged var wordName:String?
    @NSManaged var wordPath: String?
    @NSManaged var imageData: NSData?
    @NSManaged var id: NSNumber?
    @NSManaged var madlib: MadLib?
    @NSManaged var fullRes: NSManagedObject?
    
}
