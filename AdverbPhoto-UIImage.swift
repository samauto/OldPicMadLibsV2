//
//  AdverbPhoto-UIImage.swift
//  PicMadLibs
//
//  Created by Mac on 7/23/16.
//  Copyright © 2016 STDESIGN. All rights reserved.
//
import Foundation
import UIKit

extension AdverbPhoto {
    
    /// Convenience Property to get set the imageData with a UIImage
    var image : UIImage? {
        get {
            if let imageData = imageData {
                return UIImage(data: imageData)
            }
            return nil
        }
        set(value) {
            if let value = value {
                imageData = UIImageJPEGRepresentation(value, 0.7)
            }
        }
    }
}
