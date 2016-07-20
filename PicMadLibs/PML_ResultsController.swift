//
//  PML_ResultsController.swift
//  PicMadLibs
//
//  Created by Mac on 5/18/16.
//  Copyright © 2016 STDESIGN. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class PML_ResultsController: UIViewController, NSFetchedResultsControllerDelegate {

    
    // MARK: Variables
    
    var selMadList: MadLib!
    
    var NounInput: String?
    var VerbInput: String?
    var AdverbInput: String?
    var AdjectiveInput: String?
    
    @IBOutlet weak var adjectiveDisplay: UILabel!
    @IBOutlet weak var nounDisplay: UILabel!
    @IBOutlet weak var verbDisplay: UILabel!
    @IBOutlet weak var adverbDisplay: UILabel!

    @IBOutlet weak var adjectivePhotoDisplay: UIImageView!
    @IBOutlet weak var nounPhotoDisplay: UIImageView!
    @IBOutlet weak var verbPhotoDisplay: UIImageView!
    @IBOutlet weak var adverbPhotoDisplay: UIImageView!

    
    // MARK: VIEW
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up views if editing an existing PicMadLib.
        if let madList = selMadList {
            navigationItem.title = madList.madlibID as String
            
            nounDisplay.text = madList.nouns as String
            verbDisplay.text = madList.verbs as String
            adverbDisplay.text = madList.adverbs as String
            adjectiveDisplay.text = madList.adjectives as String

            loadWordImage("NounPhoto", picMadLib: madList)
            loadWordImage("VerbPhoto", picMadLib: madList)
            loadWordImage("AdverbPhoto", picMadLib: madList)
            loadWordImage("AdjectivePhoto", picMadLib: madList)
        }
        
    }//END OF FUNC: viewDidLoad
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }//END OF FUNC: viewWillAppear
    

    func loadWordImage(entityWord: String, picMadLib: MadLib)
    {
        let request = NSFetchRequest(entityName: entityWord)
        request.sortDescriptors = []
        request.predicate = NSPredicate(format: "madlib == %@", picMadLib);
        
        do {
            if (entityWord=="NounPhoto") {
                let results = try sharedContext.executeFetchRequest(request) as! [NounPhoto]
                if (results.count > 0) {
                    for result in results {
                        load_image(result.wordPath, type:entityWord)
                    }
                } else {
                    print("No "+entityWord)
                }

            }
            else if (entityWord=="VerbPhoto") {
                let results = try sharedContext.executeFetchRequest(request) as! [VerbPhoto]
                if (results.count > 0) {
                    for result in results {
                        load_image(result.wordPath, type:entityWord)
                    }
                } else {
                    print("No "+entityWord)
                }

            }
            else if (entityWord=="AdverbPhoto") {
                let results = try sharedContext.executeFetchRequest(request) as! [AdverbPhoto]
                if (results.count > 0) {
                    for result in results {
                        load_image(result.wordPath, type:entityWord)
                    }
                } else {
                    print("No "+entityWord)
                }

            }
            else {
                let results = try sharedContext.executeFetchRequest(request) as! [AdjectivePhoto]
                if (results.count > 0) {
                    for result in results {
                        load_image(result.wordPath, type:entityWord)
                    }
                } else {
                    print("No "+entityWord)
                }
            }
            
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
        
    }//END OF FUNC: loadWordImage

    
    func load_image(urlString:String, type:String)
    {
        let imgURL: NSURL = NSURL(string: urlString)!
        let request: NSURLRequest = NSURLRequest(URL: imgURL)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            
            if (error == nil && data != nil)
            {
                func display_image()
                {
                    if (type=="NounPhoto") {
                        self.nounPhotoDisplay.image = UIImage(data: data!)
                    } else if (type=="VerbPhoto") {
                        self.verbPhotoDisplay.image = UIImage(data: data!)
                    } else if (type=="AdverbPhoto") {
                        self.adverbPhotoDisplay.image = UIImage(data: data!)
                    } else {
                        self.adjectivePhotoDisplay.image = UIImage(data: data!)
                    }
                }
                
                dispatch_async(dispatch_get_main_queue(), display_image)
            }
        }
        
        task.resume()
        
    }//END OF FUNC: load_image

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "UpdatePML" {
            let madlibUpdate = segue.destinationViewController as! PML_FormController
                let selectedMadlib = selMadList
                madlibUpdate.madList = selectedMadlib
        }
            
       // else if segue.identifier == "AddItem" {
       //     print("Adding new madlib.")
       // }
        
    }//END OF FUNC prepareForSegue

    
    // MARK: - Core Data Convenience
    
    lazy var sharedContext: NSManagedObjectContext = {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }()
    
    
    @IBAction func cancelPressed(sender: AnyObject) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMadLibMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMadLibMode {
            dismissViewControllerAnimated(true, completion: nil)
            
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
    }//END OF FUNC cancelPressed

    
}//END OF CLASS: PML_ResultsController