//
//  CGSizeExtension.swift
//  PicMadLibs
//
//  Created by Mac on 7/23/16.
//  Copyright © 2016 STDESIGN. All rights reserved.
//

import Foundation
import UIKit

extension CGSize {
    
    /**
     Calculate scaled size with the same aspect ratio
     
     - parameter toSize: target size
     
     - returns: scaled size
     */
    func resizeFill(toSize: CGSize) -> CGSize {
        
        let scale : CGFloat = (self.height / self.width) < (toSize.height / toSize.width) ? (self.height / toSize.height) : (self.width / toSize.width)
        return CGSize(width: (self.width / scale), height: (self.height / scale))
        
    }
}
