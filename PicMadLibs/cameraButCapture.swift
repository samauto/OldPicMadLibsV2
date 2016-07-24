//
//  cameraButCapture.swift
//  PicMadLibs
//
//  Created by Mac on 7/23/16.
//  Copyright © 2016 STDESIGN. All rights reserved.
//

import Foundation
import UIKit

extension PML_FormController {
    
    @IBAction func nounCapture(sender: AnyObject) {
        imagePickerCheck()
        loadImagesPreview()
        entityWord = "NounPhoto"
    }
    // END OF FUNC: nounCapture
    
    @IBAction func verbCapture(sender: AnyObject) {
        imagePickerCheck()
        loadImagesPreview()
        entityWord = "VerbPhoto"
    }
    // END OF FUNC: verbCapture
    
    @IBAction func adverbCapture(sender: AnyObject) {
        imagePickerCheck()
        loadImagesPreview()
        entityWord = "AdverbPhoto"
    }
    // END OF FUNC: adverbCapture
    
    @IBAction func adjectiveCapture(sender: AnyObject) {
        imagePickerCheck()
        loadImagesPreview()
        entityWord = "AdjectivePhoto"
    }
    // END OF FUNC: adjectiveCapture
    
    func imagePickerCheck() {
        // unwrap the imagePicker
        guard let imagePicker = imagePicker else {
            cantOpenPicker(withSource: sourceType)
            return
        }
        
        // present the imagePicker
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    // END OF FUNC: imagePickerCheck
    
    func loadImagesPreview() {
        // loadImage function with a completion block
        loadImages { (images) -> Void in
            if (self.entityWord == "NounPhoto") {
                if let thumbnailData = images?.last?.thumbnailNoun?.imageData {
                    let image = UIImage(data: thumbnailData)
                    self.nounImgPreview.image = image
                }
            
            } else if (self.entityWord == "VerbPhoto") {
                if let thumbnailData = images?.last?.thumbnailVerb?.imageData {
                    let image = UIImage(data: thumbnailData)
                    self.verbImgPreview.image = image
                }
                    
            } else if (self.entityWord == "AdverbPhoto") {
                if let thumbnailData = images?.last?.thumbnailAdverb?.imageData {
                    let image = UIImage(data: thumbnailData)
                    self.adverbImgPreview.image = image
                }
            
            } else {
                if let thumbnailData = images?.last?.thumbnailAdjective?.imageData {
                    let image = UIImage(data: thumbnailData)
                    self.adjectiveImgPreview.image = image
                }
            }
        }
    }
    //END OF FUNC: loadImagesPreview

}
//END OF EXTENSION: cameraButCapture