//
//  CoreDataSetup.swift
//  PicMadLibs
//
//  Created by Mac on 7/23/16.
//  Copyright © 2016 STDESIGN. All rights reserved.
//

import Foundation
import CoreData
import UIKit


extension PML_FormController{
    
    /**
     Start Core Data managed context on the correct queue
     */
    func coreDataSetup() {
        
        Run.sync(coreDataQueue) {
            self.managedContext = CoreDataStackManager.sharedInstance().managedObjectContext
        }
        
    }
}
