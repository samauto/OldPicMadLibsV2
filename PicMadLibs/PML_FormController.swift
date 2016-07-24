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

class PML_FormController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, NSFetchedResultsControllerDelegate   {

    
    // MARK: FORM
    
    // MESSAGE
    @IBOutlet weak var formMessage: UILabel!

    
    // MARK: WORD PROPERTIES

    // NOUN
    @IBOutlet weak var nounInfo: UIButton!
    @IBOutlet weak var nounInput: UITextField!
    
    // VERB
    @IBOutlet weak var verbInfo: UIButton!
    @IBOutlet weak var verbInput: UITextField!
    
    // ADVERB
    @IBOutlet weak var adverbInfo: UIButton!
    @IBOutlet weak var adverbInput: UITextField!
    
    // ADJECTIVE
    @IBOutlet weak var adjectiveInfo: UIButton!
    @IBOutlet weak var adjectiveInput: UITextField!


    // MARK: WORD IMAGE PROPERTIES
    
    // NOUN IMAGE
    @IBOutlet weak var nounCamButton: UIButton!
    @IBOutlet weak var nounImgPreview: UIImageView!
    @IBOutlet weak var nounActivity: UIActivityIndicatorView!

    // VERB IMAGE
    @IBOutlet weak var verbCamButton: UIButton!
    @IBOutlet weak var verbImgPreview: UIImageView!
    @IBOutlet weak var verbActivity: UIActivityIndicatorView!
    
    
    // ADVERB IMAGE
    @IBOutlet weak var adverbCamButton: UIButton!
    @IBOutlet weak var adverbImgPreview: UIImageView!
    @IBOutlet weak var adverbActivity: UIActivityIndicatorView!
    
    
    // ADJECTIVE IMAGE
    @IBOutlet weak var adjectiveCamButton: UIButton!
    @IBOutlet weak var adjectiveImgPreview: UIImageView!
    @IBOutlet weak var adjectiveActivity: UIActivityIndicatorView!
    
    /// The UIImagePickerController to capture or load image.
    var imagePicker : UIImagePickerController?

    /// A dispatch queue to convert images to jpeg and to thumbnail size
    let imageProcessingQueue = dispatch_queue_create("imageProcessingQueue", DISPATCH_QUEUE_CONCURRENT)
    
    /// A dispatch queue for the Core Data managed context
    let coreDataQueue = dispatch_queue_create("coreDataQueue", DISPATCH_QUEUE_CONCURRENT)

    /// The Core Data managed context
    var managedContext: NSManagedObjectContext?
    var managedContextNoun: NSManagedObjectContext?
    var managedContextVerb: NSManagedObjectContext?
    var managedContextAdverb: NSManagedObjectContext?
    var managedContextAdjective: NSManagedObjectContext?
    
    lazy var sharedContext: NSManagedObjectContext = {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }()

    /// The SourceType for UIImagePickerController
    var sourceType : UIImagePickerControllerSourceType = .PhotoLibrary // don't use camera in the simulator
    
    
    
    // MARK: API OPTION
    
    var madList: MadLib?
    var wordData : NSData? = nil

    var entityWord: String = ""
    

    // MARK: BUTTONS
    
    @IBOutlet weak var generatePicMadLib: UIButton!
    @IBOutlet weak var generateRandom: UIBarButtonItem!

    
       
    
    // MARK: VIEW
    override func viewDidLoad() {
        super.viewDidLoad()
        // verify source and assign value to imagePicker
        imagePickerSetup(forSource: sourceType)
        
        // setup Core Data on the correct thread
        coreDataSetup()
        
        nounActivity.hidden = true
        verbActivity.hidden = true
        adverbActivity.hidden = true
        adjectiveActivity.hidden = true
        
        formMessage.text = "to create your PicMadLib. You have two options for Pics you can let us find a pic or click on the Camera icon to use your own pic"
        formMessage.hidden = false
        
        // Set up views if editing an existing MadLib.
        if let madList = madList {
            navigationItem.title = madList.madlibID as String
            nounInput.text = madList.nouns as String
            verbInput.text = madList.verbs as String
            adverbInput.text = madList.adverbs as String
            adjectiveInput.text = madList.adjectives as String
            generatePicMadLib.setTitle("UPDATE", forState: UIControlState.Normal)
        }
    }
    //END OF FUNC: viewDidLoad

    

    
    
    

    
    
    
    //MARK: NAVIGATION

    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ResultsPML" {
            
            let PML_Results_NavigationController = segue.destinationViewController as! UINavigationController
            let madlibDetail = PML_Results_NavigationController.topViewController as! PML_ResultsController
            
            // Get the cell that generated this segue.
            madlibDetail.selMadList = self.madList
            madlibDetail.newOrupdate = "New"
        }
        
    }
    //END OF FUNC: prepareForSeque

    
    //MARK; BUTTONS
    
    @IBAction func cancelPressed(sender: AnyObject) {
        let isPresentingInAddMadLibMode = presentingViewController is UINavigationController

        if isPresentingInAddMadLibMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
        
    }
    //END OF FUNC cancelPressed
    
    
    @IBAction func generatePressed(sender: AnyObject) {
        if (generatePicMadLib === sender) || (generateRandom === sender) {
            
            let randID = Int(arc4random_uniform(1000000) + 1)
            let tempID = "PicMadLib_"+String(randID)
            
            // If fields are blank and Generate button is pressed the field will be filled with a random Word
            randWordGenButt()
           
            //Add the new or updated MadLib to the List
            madList = MadLib(madID: tempID, noun: self.nounInput.text!, verb: self.verbInput.text!, adverb: self.adverbInput.text!, adjective: self.adjectiveInput.text!, context: self.sharedContext)
            
            findPhotos(madList!, noun: self.nounInput.text!,  verb: self.verbInput.text!,  adverb: self.adverbInput.text!,  adjective: self.adjectiveInput.text!)

            CoreDataStackManager.sharedInstance().saveContext()
        }
        
    }
    //END OF FUNC: generatePressed
    
}//END OF CLASS: PML_FormController

