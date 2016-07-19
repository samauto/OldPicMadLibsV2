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

    
    var selMadList: MadLib!
    
    // MARK: Variables
    
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
        
       // print(self.loadNouns.objectAtIndexPath(1] as! NounPhoto)
        
        // Set up views if editing an existing Meal.
        if let madList = selMadList {
            navigationItem.title = madList.madlibID as String
            
            nounDisplay.text = madList.nouns as String
            verbDisplay.text = madList.verbs as String
            adverbDisplay.text = madList.adverbs as String
            adjectiveDisplay.text = madList.adjectives as String

            
    
            var request = NSFetchRequest(entityName: "NounPhoto")
            request.sortDescriptors = []
            request.predicate = NSPredicate(format: "madlib == %@", selMadList!);
            
            do {
                let results = try sharedContext.executeFetchRequest(request) as! [NounPhoto]
                if (results.count > 0) {
                    for result in results {
                        load_image(result.wordPath)
                        print(result.photoWordImage)
                        print(result.wordPath)
                        adjectivePhotoDisplay.image = UIImage(named:result.wordPath)
                        nounPhotoDisplay.image = UIImage(named:"Generate")
                        verbPhotoDisplay.image = UIImage(named:"Generate")
                        adverbPhotoDisplay.image = UIImage(named:"Generate")
                    }
                } else {
                    print("No Users")
                }
            } catch let error as NSError {
                // failure
                print("Fetch failed: \(error.localizedDescription)")
            }

            
            print("DETAILS")
    
//            let path = loadWordImage("NounPhoto", picMadLib: madList)
//            print ("PATH", path)
//            adjectivePhotoDisplay.image = UIImage(named:path)
//            nounPhotoDisplay.image = UIImage(named:"Generate")
//            verbPhotoDisplay.image = UIImage(named:"Generate")
//            adverbPhotoDisplay.image = UIImage(named:"Generate")

        }
        
    }//END OF FUNC: viewDidLoad
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }//END OF FUNC: viewWillAppear
    

    func loadWordImage(entityWord:String, picMadLib: MadLib)->String
    {
        var request = NSFetchRequest(entityName: entityWord)
        request.sortDescriptors = []
        request.predicate = NSPredicate(format: "madlib == %@", picMadLib);
        
        do {
            let results = try sharedContext.executeFetchRequest(request) as! [WordPhoto]
            if (results.count > 0) {
                for result in results {
                    let imageURL = NSURL(string: result.wordPath)
                    return result.wordPath
                    load_image(result.wordPath)
                    //adjectivePhotoDisplay.image = UIImage(named:result.wordPath)
                    //nounPhotoDisplay.image = UIImage(named:"Generate")
                    //verbPhotoDisplay.image = UIImage(named:"Generate")
                    //adverbPhotoDisplay.image = UIImage(named:"Generate")
                }
            } else {
                print("No Users")
            }
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
        
        return "no path"
        
        
    }//END OF FUNC: loadWordImage

    
    
    func load_image(urlString:String)
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
                    self.nounPhotoDisplay.image = UIImage(data: data!)
                }
                
                dispatch_async(dispatch_get_main_queue(), display_image)
            }
            
        }
        
        task.resume()
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print ("SEGUE1", segue.identifier)
        
        if segue.identifier == "UpdatePML" {
            let madlibUpdate = segue.destinationViewController as! PML_FormController
                let selectedMadlib = selMadList
                madlibUpdate.madList = selectedMadlib
                print("madlibUpdate", madlibUpdate.madList)
                print("UPDATED2")
        }
        
        
        else if segue.identifier == "AddItem" {
            print("Adding new madlib.")
        }
        
    }//END OF FUNC prepareForSegue

    
    
    // MARK: - Core Data Convenience
    
    lazy var sharedContext: NSManagedObjectContext = {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }()
    
    
    
    
    
    // MARK: Collection View
    
    // MARK: - Load Photos
    
    lazy var loadPhotos: NSFetchedResultsController = {
        
        let fetchRequest = NSFetchRequest(entityName: "nounPhoto")
        //fetchRequest.sortDescriptors = []
        //fetchRequest.predicate = NSPredicate(format: "pin == %@", self.selpin);
        
        let loadPhotos = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.sharedContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return loadPhotos
        
    }()//END OF VAR: load Photos
    
    
    //MARK: CORE DATA: Fetch PicMadLibs
    
    func loadMadLibs() -> [MadLib]? {
        
        // Create the Fetch Request
        let fetchRequest = NSFetchRequest(entityName: "nounPhoto")
        
        // Execute the Fetch Request
        var savedMadLibs = [MadLib]()
        do {
            savedMadLibs = try sharedContext.executeFetchRequest(fetchRequest) as! [MadLib]
        } catch {
            print ("Problem with retrieving PicMadLibs from Core Data!")
        }
        
        return savedMadLibs
        
    }//END OF FUNC: loadMadLibs()

    
    
    
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