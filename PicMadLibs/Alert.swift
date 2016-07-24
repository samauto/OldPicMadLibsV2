//
//  Alert.swift
//  PicMadLibs
//
//  Created by Mac on 7/23/16.
//  Copyright © 2016 STDESIGN. All rights reserved.
//

import Foundation
import UIKit

extension PML_FormController{
    
    /**
     Display Alert when the ImagePicker sourceType is unavailable
     
     - parameter source: UIImagePickerControllerSourceType
     */
    func cantOpenPicker(withSource source:UIImagePickerControllerSourceType) {
        
        let sourceName : String
        
        switch source {
        case .Camera : sourceName = "Camera"
        case .PhotoLibrary : sourceName = "Photo Library"
        case .SavedPhotosAlbum : sourceName = "Saved Photos Album"
        }
        
        let alertAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        
        let alertVC = UIAlertController(title: "Sorry", message: "Can't access your \(sourceName)", preferredStyle: .Alert)
        
        alertVC.addAction(alertAction)
        
        self.presentViewController(alertVC, animated: true, completion: nil)
    }
    
    /**
     Display Alert when loadImages had no results
     */
    func noImagesFound() {
        
        let alertAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        
        let alertVC = UIAlertController(title: "No Images Found", message: "There were no images saved in Core Data", preferredStyle: .Alert)
        
        alertVC.addAction(alertAction)
        
        self.presentViewController(alertVC, animated: true, completion: nil)
    }

    
    //FUNC: popAlert(): Display an Alrt Box
    func popAlert(typeOfAlert: String, errorString: String) {
        
        let alertController = UIAlertController(title: typeOfAlert, message: errorString, preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    //END OF FUNC: popAlert()
    
}
