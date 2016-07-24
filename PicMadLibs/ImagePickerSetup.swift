//
//  ImagePickerSetup.swift
//  PicMadLibs
//
//  Created by Mac on 7/23/16.
//  Copyright © 2016 STDESIGN. All rights reserved.
//

import Foundation
import UIKit


extension PML_FormController : UIImagePickerControllerDelegate {
    
    /**
     Setup imagePicker and display Alert if it is not possible
     */
    func imagePickerSetup() {
        
        imagePickerSetup(forSource: .PhotoLibrary)
        
    }
    
    /**
     Setup imagePicker and display Alert if it is not possible
     
     - parameter source: The Source for the imagePicker
     */
    func imagePickerSetup(forSource source : UIImagePickerControllerSourceType) {
        if canStartPicker(forSource: source, withAlert: true) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = source
            
            self.imagePicker = picker
        }
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        prepareImageForSaving(image)
    }
}
