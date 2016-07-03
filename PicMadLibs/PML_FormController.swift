//
//  ViewController.swift
//  PicMadLibs
//
//  Created by Mac on 5/18/16.
//  Copyright © 2016 STDESIGN. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class PML_FormController: UIViewController {

    
    // MARK: PROPERTIES
    var madLists = [MadLib]()
    
    // MARK: NOUN
    @IBOutlet weak var nounInfo: UIButton!
    @IBOutlet weak var nounInput: UITextField!
    
    
    // MARK: VERB
    @IBOutlet weak var verbInfo: UIButton!
    @IBOutlet weak var verbInput: UITextField!
    
    
    // MARK: ADVERB
    @IBOutlet weak var adverbInfo: UIButton!
    @IBOutlet weak var adverbInput: UITextField!
    
    
    // MARK: ADJECTIVE
    @IBOutlet weak var adjectiveInfo: UIButton!
    @IBOutlet weak var adjectiveInput: UITextField!
    
    
    // MARK: GENERATE
    @IBOutlet weak var generatePicMadLib: UIButton!
    
    
    // MARK: MESSAGE
    @IBOutlet weak var formMessage: UILabel!
    
    
    // MARK: VIEW
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formMessage.hidden = true
        
    }//END OF FUNC: viewDidLoad

    
    // MARK: CORE DATA ShareContext
    lazy var sharedContext: NSManagedObjectContext = {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }()
    
    
    
    // MARK: ACTION
    
    @IBAction func AdjectiveHelp(sender: AnyObject) {
        let whatisAdjective = "Adjective are words that describe or modify other words, making your writing and speaking much more specific, and a whole lot more interesting. Words like small, blue, and sharp are descriptive, and they are all examples of adjectives. Because adjectives are used to identify or quantity individual people and unique things, they are usually positioned before he noun or pronoun that they modify."
        
        let adjectiveAlert = UIAlertController (title: "What is an Adjective?",
            message: whatisAdjective, preferredStyle: UIAlertControllerStyle.Alert)
        let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil)
        adjectiveAlert.addAction(closeAction)
        self.presentViewController(adjectiveAlert, animated: true, completion: nil)
        
    }// END OF ADJECTIVE HELP
    
    @IBAction func AdverbHelp(sender: AnyObject) {
        let whatisAdverb = "An adverb is a word that is an used to change or qualify the meaning of an adjective, a verb, a clause, another adverb, or any other type of word or phase with the exception of determiners and adjectives that directly modify nouns."
        
        let adverbAlert = UIAlertController (title: "What is an Adverb?",
            message: whatisAdverb, preferredStyle: UIAlertControllerStyle.Alert)
        let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil)
        adverbAlert.addAction(closeAction)
        self.presentViewController(adverbAlert, animated: true, completion: nil)
        
    }// END OF ADVERB HELP
    
    @IBAction func VerbHelp(sender: AnyObject) {
        let whatisVerb = "A verb is one of the main parts of a sentence or question in English. In fact, you can't have a sentence or a question without a verb! That's how important these 'action' parts of speech are. The verb signals an action, an occurance, or a state of being. Whether mental, physical, or mechanical, verbs always express activity."
        
        let verbAlert = UIAlertController (title: "What is a Verb?",
            message: whatisVerb, preferredStyle: UIAlertControllerStyle.Alert)
        let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil)
        verbAlert.addAction(closeAction)
        self.presentViewController(verbAlert, animated: true, completion: nil)
        
    }// END OF VERB HELP
    
    @IBAction func NounHelp(sender: AnyObject) {
        let whatisNoun = "Of all the parts of speech, nouns are perhaps the most important. A noun is a word that identifies a person, animal, place, thing, or idea. Here, we'll take a closer look at what makes a noun a noun, and we'll provide some noun examples, along with some advice for using nouns in your sentences."
        
        let nounAlert = UIAlertController (title: "What is a Noun",
            message: whatisNoun, preferredStyle: UIAlertControllerStyle.Alert)
        let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil)
        nounAlert.addAction(closeAction)
        self.presentViewController(nounAlert, animated: true, completion: nil)
    }// END OF NOUN HELP
    
    
    @IBAction func cancelPressed(sender: AnyObject) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMadLibMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMadLibMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
    }//END OF FUNC cancelPressed
    
    
    
    @IBAction func generatePressed(sender: AnyObject) {
        //DEBUG: print("Pressed")
        //DEBUG: print(selectedPhotos.count)
        
        print("noun1", nounInput.text!)
        print("verb2", verbInput.text!)
        print("adverb3", adverbInput.text!)
        print("adjective4", adjectiveInput.text!)
        
        let randID = Int(arc4random_uniform(1000) + 1)
        let tempID = nounInput.text!+verbInput.text!+adverbInput.text!+adjectiveInput.text!+String(randID)
        print (tempID)
        
        performOnMain {
            let madlibAdd = MadLib(madID:tempID,
        //        nouns:nounInput.text,
        //       verbs:verbInput.text,
        //        adverbs:adverbInput.text,
        //        adjectives:adjectiveInput.text,
                context: self.sharedContext)
            
            print ("madlib:", madlibAdd.madlibID)
            
            self.findPhotos(self.nounInput.text!)
            
            self.madLists.append(madlibAdd)
            //print("madlists----", self.madLists)
            
            
            
            CoreDataStackManager.sharedInstance().saveContext()
            
            
            //let controller = self.storyboard!.instantiateViewControllerWithIdentifier("PML_TableViewController") as! PML_TableViewController
            
            //controller.actor = actors[indexPath.row]
            
            //self.navigationController!.pushViewController(controller, animated: true)
        }
    }//END OF FUNC: generatePressed
    
    
    func findPhotos(word: String) {
        print("findPhotos", word)
        
        FlickrAPI.sharedInstance().getPhotos(word) { (success, results, errorString) in
            if success == false {
                performOnMain {
                    print("Error can't find find Photos via Flickr")
                }
            }
        }
        
    }//END OF FUNC: findPhotos

    
    
    // MARK: SEGUE
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let formResults: PML_ResultsController = segue.destinationViewController as? PML_ResultsController {
            
            formResults.NounInput = nounInput.text!
            formResults.VerbInput = verbInput.text!
            formResults.AdverbInput = adverbInput.text!
            formResults.AdjectiveInput = adjectiveInput.text!
        }
    }//END OF SEQUE

    
    

}//END OF CLASS: PML_FormController

