//
//  FullRes+CoreDataProperties.swift
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

extension FullRes {

    @NSManaged var imageData: NSData?
    @NSManaged var thumbnailNoun: NounPhoto?
    @NSManaged var thumbnailVerb: VerbPhoto?
    @NSManaged var thumbnailAdverb: AdverbPhoto?
    @NSManaged var thumbnailAdjective: AdjectivePhoto?

}
