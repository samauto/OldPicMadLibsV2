//
//  MadLib+CoreDataProperties.swift
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

extension MadLib {
    
    // MARK: PROPERTIES
    @NSManaged var madlibID: NSString
    @NSManaged var nouns: NSString
    @NSManaged var verbs: NSString
    @NSManaged var adverbs: NSString
    @NSManaged var adjectives: NSString
    
    @NSManaged var nounPhoto: [NounPhoto]
    @NSManaged var verbPhoto: [VerbPhoto]
    @NSManaged var adverbPhoto: [AdverbPhoto]
    @NSManaged var adjectivePhoto: [AdjectivePhoto]
    
    @NSManaged var timeStamp: NSDate
    
}

