//
//  Savingimages.swift
//  PicMadLibs
//
//  Created by Mac on 7/23/16.
//  Copyright © 2016 STDESIGN. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension PML_FormController{
    
    /**
     Convert Image to JPEG and generate a thumbnail
     
     - parameter image: a captured image
     */
    func prepareImageForSaving(image:UIImage) {
        
        // use date as unique id
        let date : Double = NSDate().timeIntervalSince1970
        
        startActivity()
        // dispatch with gcd.
        Run.async(imageProcessingQueue) {
            
            // create NSData from UIImage
            guard let imageData = UIImageJPEGRepresentation(image, 1) else {
                // handle failed conversion
                print("jpg error")
                return
            }
            
            // scale image
            let thumbnail = image.scale(toSize: self.view.frame.size)
            
            guard let thumbnailData  = UIImageJPEGRepresentation(thumbnail, 0.7) else {
                // handle failed conversion
                print("jpg error")
                return
            }
            
            // send to save function
            self.saveImage(imageData, thumbnailData: thumbnailData, date: date)
            
            self.stopActivity()
            
        }
    }
}

extension PML_FormController {
   
    /**
     Save image to Core Data
     
     - parameter imageData:     NSData representation of the original image
     - parameter thumbnailData: NSData representation of the thumbnail image
     - parameter date:          timestamp
     */
    func saveImage(imageData:NSData, thumbnailData:NSData, date: Double) {
        
        startActivity()
        
        let entityName = entityWord
        print("entity", entityName)
        
        Run.barrierSync(coreDataQueue) {
            
            // create new objects in moc
            guard let mocNoun = self.managedContextNoun else {
                return
            }
            guard let mocVerb = self.managedContextVerb else {
                return
            }
            guard let mocAdverb = self.managedContextAdverb else {
                return
            }
            guard let mocAdjective = self.managedContextAdjective else {
                return
            }
            
            if (entityName == "NounPhoto") {
                guard let fullRes = NSEntityDescription.insertNewObjectForEntityForName("FullRes", inManagedObjectContext: mocNoun) as? FullRes, let thumbnail = NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: mocNoun) as? NounPhoto
                        else {
                            // handle failed new object in moc
                            print("mocNoun error")
                            return
                        }
                
                //set image data of thumbnail
                thumbnail.imageData = thumbnailData
                thumbnail.id = date as NSNumber
                thumbnail.fullRes = fullRes
                
                // save the new objects
                do {
                    try mocNoun.save()
                } catch {
                    fatalError("Failure to save context: \(error)")
                }
                
                // clear the moc
                mocNoun.refreshAllObjects()

                
            } else if (entityName == "VerbPhoto") {
                guard let fullRes = NSEntityDescription.insertNewObjectForEntityForName("FullRes", inManagedObjectContext: mocVerb) as? FullRes, let thumbnail = NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: mocVerb) as? VerbPhoto
                        else {
                            // handle failed new object in moc
                            print("mocVerb error")
                            return
                        }
                
                //set image data of thumbnail
                thumbnail.imageData = thumbnailData
                thumbnail.id = date as NSNumber
                thumbnail.fullRes = fullRes
                
                // save the new objects
                do {
                    try mocVerb.save()
                } catch {
                    fatalError("Failure to save context: \(error)")
                }
                
                // clear the moc
                mocVerb.refreshAllObjects()


            } else if (entityName == "AdverbPhoto") {
                guard let fullRes = NSEntityDescription.insertNewObjectForEntityForName("FullRes", inManagedObjectContext: mocAdverb) as? FullRes, let thumbnail = NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: mocAdverb) as? AdverbPhoto
                        else {
                            // handle failed new object in moc
                            print("mocAdverb error")
                            return
                        }
                
                //set image data of thumbnail
                thumbnail.imageData = thumbnailData
                thumbnail.id = date as NSNumber
                thumbnail.fullRes = fullRes
                
                // save the new objects
                do {
                    try mocAdverb.save()
                } catch {
                    fatalError("Failure to save context: \(error)")
                }
                
                // clear the moc
                mocAdverb.refreshAllObjects()
                
            } else {
            
                guard let fullRes = NSEntityDescription.insertNewObjectForEntityForName("FullRes", inManagedObjectContext: mocAdjective) as? FullRes, let thumbnail = NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: mocAdjective) as? AdverbPhoto
                        else {
                            // handle failed new object in moc
                            print("mocAdjective error")
                            return
                        }
                //set image data of fullres
                fullRes.imageData = imageData
                
                //set image data of thumbnail
                thumbnail.imageData = thumbnailData
                thumbnail.id = date as NSNumber
                thumbnail.fullRes = fullRes
                
                // save the new objects
                do {
                    try mocAdjective.save()
                } catch {
                    fatalError("Failure to save context: \(error)")
                }
                
                // clear the moc
                mocAdjective.refreshAllObjects()
            }
            
        }
    }
    //END OF FUNC: saveImage
    
}
//END OF EXTENSION: Savingimages
