//
//  VerifyPickerSource.swift
//  PicMadLibs
//
//  Created by Mac on 7/23/16.
//  Copyright © 2016 STDESIGN. All rights reserved.
//


import Foundation
import UIKit
import MobileCoreServices

extension PML_FormController {
    
    /**
     Verify Source for UIImagePickerController
     
     - parameter alert: show Alert if check fails
     
     - returns: true if Source is available
     */
    func canStartPicker(forSource source: UIImagePickerControllerSourceType, withAlert alert:Bool) -> Bool {
        
        let result = pickerCanStart(withSource: source)
        if !result && alert {
            cantOpenPicker(withSource: source)
        }
        return result
    }
    
    private func pickerCanStart(withSource source:UIImagePickerControllerSourceType) -> Bool {
        
        guard UIImagePickerController.isSourceTypeAvailable(source) else {
            return false
        }
        guard let sourceTypes = UIImagePickerController.availableMediaTypesForSourceType(source) where sourceTypes.contains(String(kUTTypeImage)) else {
            return false
        }
        
        return true
    }
}
