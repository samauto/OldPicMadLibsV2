//
//  Word_Defintions.swift
//  PicMadLibs
//
//  Created by Mac on 7/23/16.
//  Copyright © 2016 STDESIGN. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension PML_FormController{
    
    
    // MARK: WORD DEFINITIONS HELP

    @IBAction func NounHelp(sender: AnyObject) {
        wordHelp("noun")
    }
    // END OF NOUN HELP
    
    @IBAction func VerbHelp(sender: AnyObject) {
        wordHelp("verb")
        
    }
    // END OF VERB HELP
    
    @IBAction func AdverbHelp(sender: AnyObject) {
        wordHelp("adverb")
    }
    // END OF ADVERB HELP
    
    @IBAction func AdjectiveHelp(sender: AnyObject) {
        wordHelp("adverb")
    }
    // END OF ADJECTIVE HELP
    
    
    func wordHelp(type:String) {
        
        var wordTitle: String = ""
        var whatisWord: String = ""
        var exWord: String = ""
        var wordMessage: String = ""
        
        if (type == "noun") {
            wordTitle = WordConstants.NounInfo.Title
            whatisWord = WordConstants.NounInfo.WhatIs
            exWord = WordConstants.NounInfo.Example
        
        } else if (type == "verb") {
            wordTitle = WordConstants.VerbInfo.Title
            whatisWord = WordConstants.VerbInfo.WhatIs
            exWord = WordConstants.VerbInfo.Example

        } else if (type == "adverb") {
            wordTitle = WordConstants.AdverbInfo.Title
            whatisWord = WordConstants.AdverbInfo.WhatIs
            exWord = WordConstants.AdverbInfo.Example
            
        } else {
            wordTitle = WordConstants.AdjectiveInfo.Title
            whatisWord = WordConstants.AdjectiveInfo.WhatIs
            exWord = WordConstants.AdjectiveInfo.Example
            
        }
        wordMessage = whatisWord+exWord
        wordAlert(wordTitle, message: wordMessage)
    
    }
    // END OF FUNC: wordHelp
    
    
    func wordAlert(title: String, message: String) {
        let wordAlert = UIAlertController (title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil)
        wordAlert.addAction(closeAction)
        self.presentViewController(wordAlert, animated: true, completion: nil)
    }
    // END OF FUNC: wordAlert
    
}
// END OF EXTENSION: wordInfo
