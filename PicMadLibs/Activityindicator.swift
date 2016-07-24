//
//  Activityindicator.swift
//  PicMadLibs
//
//  Created by Mac on 7/23/16.
//  Copyright © 2016 STDESIGN. All rights reserved.
//

import Foundation


extension PML_FormController {
    
    func startActivity() {
        Run.main {
            if (self.entityWord == "NounPhoto") {
                self.nounActivity.hidden = false
                self.nounActivity.startAnimating()
            }
            else if (self.entityWord == "VerbPhoto") {
                self.verbActivity.hidden = false
                self.verbActivity.startAnimating()
            }
            else if (self.entityWord == "AdverbPhoto") {
                self.adverbActivity.hidden = false
                self.adverbActivity.startAnimating()
            }
            else {
                self.adjectiveActivity.hidden = false
                self.adjectiveActivity.startAnimating()
            }
        }
    }
    
    func stopActivity() {
        Run.main {
            if (self.entityWord == "NounPhoto") {
                self.nounActivity.hidden = true
                self.nounActivity.stopAnimating()
            }
            else if (self.entityWord == "VerbPhoto") {
                self.verbActivity.hidden = true
                self.verbActivity.stopAnimating()
            }
            else if (self.entityWord == "AdverbPhoto") {
                self.adverbActivity.hidden = true
                self.adverbActivity.stopAnimating()
            }
            else {
                self.adjectiveActivity.hidden = true
                self.adjectiveActivity.stopAnimating()
            }
        }
    }

}
