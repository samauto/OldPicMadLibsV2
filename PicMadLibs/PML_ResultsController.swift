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
    var newOrupdate: String = "Update"
    
    // MARK: Inputs
    var NounInput: String?
    var VerbInput: String?
    var AdverbInput: String?
    var AdjectiveInput: String?
    
    // MARK: Images
    var NounImage: UIImage?
    var VerbImage: UIImage?
    var AdverbImage: UIImage?
    var AdjectiveImage: UIImage?
    
    // MARK: Word Photo Loading Progress
    @IBOutlet weak var adjectiveProgressView: UIProgressView!
    @IBOutlet weak var adjectiveProgressLabel: UILabel!
    
    // MARK: Word Display
    @IBOutlet weak var adjectiveDisplay: UILabel!
    @IBOutlet weak var nounDisplay: UILabel!
    @IBOutlet weak var verbDisplay: UILabel!
    @IBOutlet weak var adverbDisplay: UILabel!

    // MARK: Word Photo Display
    @IBOutlet weak var adjectivePhotoDisplay: UIImageView!
    @IBOutlet weak var nounPhotoDisplay: UIImageView!
    @IBOutlet weak var verbPhotoDisplay: UIImageView!
    @IBOutlet weak var adverbPhotoDisplay: UIImageView!

    @IBOutlet weak var cancelButton: UIBarButtonItem!
    

    
    
    // MARK: VIEW
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addControls()
        
        // Set up views if editing an existing PicMadLib.
        if let madList = selMadList {
            navigationItem.title = madList.madlibID as String
            
            nounDisplay.text = madList.nouns as String
            verbDisplay.text = madList.verbs as String
            adverbDisplay.text = madList.adverbs as String
            adjectiveDisplay.text = madList.adjectives as String
            
            if (newOrupdate == "New") {
                cancelButton.title = "Home"
                //loadWordImage("NounPhoto", picMadLib: madList)
                
            /*
                let picMadLib = madList
                let entityWord = "NounPhoto"
                let request = NSFetchRequest(entityName: entityWord)
                request.sortDescriptors = []
                request.predicate = NSPredicate(format: "madlib == %@", picMadLib);

                let loadPhotos = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.sharedContext, sectionNameKeyPath: nil, cacheName: nil)
                
                do {
                    try loadPhotos.performFetch()
                } catch {
                    print("Error fetching Pictures for pin: \(error)")
                    abort()
                }
                
                loadPhotos.delegate = self
                
                print("LOAD", loadPhotos)
                
                if photo.photoImage == nil {
                    
                    //Load new Photos for the Pin
                    
                    cell.photoCell.image = UIImage(named: "PlaceHolder")
                    cell.photoLoading.startAnimating()
                    
                    FlickrAPI.sharedInstance().displayPhoto(photo) { (success, errorString) in
                        if success {
                            performOnMain {
                                cell.photoCell?.image = photo.photoImage
                                cell.photoLoading.stopAnimating()
                            }
                        } else {
                            performOnMain {
                                cell.photoCell.image = UIImage(named: "PlaceHolder")
                                cell.photoLoading.stopAnimating()
                                print(errorString)
                            }
                        }
                    }
                    
                } else {
                    
                    // Load Stored Photos for the Pin
                    
                    performOnMain {
                        cell.photoCell?.image = photo.photoImage
                    }
                }

                */
            } else {
                loadWordImage("NounPhoto", picMadLib: madList)
                loadWordImage("VerbPhoto", picMadLib: madList)
                loadWordImage("AdverbPhoto", picMadLib: madList)
                loadWordImage("AdjectivePhoto", picMadLib: madList)
            }
        }
        
    }
    //END OF FUNC: viewDidLoad
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    //END OF FUNC: viewWillAppear
    

    // MARK: IMAGES/PHOTOS
    
    func addControls() {
        //Create Progress View Control
        adjectiveProgressView = UIProgressView(progressViewStyle: UIProgressViewStyle.Default)
        adjectiveProgressView?.center = self.view.center
        //view.addSubview(adjectiveProgressView!)
    
        //Add Label
        adjectiveProgressLabel = UILabel()
        //let frame = CGRectMakeview.center.x - 25, view.center.y - 100, 100, 50)
        //adjectiveProgressLabal?.frame = frame
        //view.addSubview(progressLabel!)
    
    }
    //END OF FUNC: addControls
    
    func updateProgress() {
        //adjectiveProgressView?.progress +=0.05
        
        let pogressValue = self.adjectiveProgressView?.progress
        //adjectiveProgressLabel.text = "\(progressValue! * 100) %"
    }
    
    
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
                        self.nounPhotoDisplay.image = UIImage(data: result.imageData!)
                        
                        //load_image(result.wordPath, type:entityWord)
                    }
                } else {
                    print("No "+entityWord)
                }

            }
            else if (entityWord=="VerbPhoto") {
                let results = try sharedContext.executeFetchRequest(request) as! [VerbPhoto]
                if (results.count > 0) {
                    for result in results {
                        self.verbPhotoDisplay.image = UIImage(data: result.imageData!)
                    }
                } else {
                    print("No "+entityWord)
                }

            }
            else if (entityWord=="AdverbPhoto") {
                let results = try sharedContext.executeFetchRequest(request) as! [AdverbPhoto]
                if (results.count > 0) {
                    for result in results {
                        self.adverbPhotoDisplay.image = UIImage(data: result.imageData!)
                    }
                } else {
                    print("No "+entityWord)
                }

            }
            else {
                let results = try sharedContext.executeFetchRequest(request) as! [AdjectivePhoto]
                if (results.count > 0) {
                    for result in results {
                        self.adjectivePhotoDisplay.image = UIImage(data: result.imageData!)
                    }
                } else {
                    print("No "+entityWord)
                }
            }
            
        } catch let error as NSError {
            // failure
            popAlert("ERROR", errorString: "Fetch failed: \(error.localizedDescription)")
        }
        
    }
    //END OF FUNC: loadWordImage

    // Function to GENERATE the PicMadLib Image
    func generatePML() -> UIImage {
        
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let PMLImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return PMLImage
    }
    //END OF FUNC: generatePML
    
    
    // Function to Share the PicMadLib
    @IBAction func picmadlibShare(sender: AnyObject) {

        let PMLImage = generatePML()
        let activityController = UIActivityViewController(activityItems: [PMLImage], applicationActivities: nil)
        
        activityController.completionWithItemsHandler = {
            activity, completed, returned, error in
            }
        presentViewController(activityController, animated: true, completion: nil)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "UpdatePML" {

            let PML_Form_NavigationController = segue.destinationViewController as! UINavigationController
            let madlibUpdate = PML_Form_NavigationController.topViewController as! PML_FormController

          //  let madlibUpdate = segue.destinationViewController as! PML_FormController
                let selectedMadlib = selMadList
                madlibUpdate.madList = selectedMadlib
        }
            
    }
    //END OF FUNC prepareForSegue

    
    // MARK: - Core Data Convenience
    
    lazy var sharedContext: NSManagedObjectContext = {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }()
    
    
    @IBAction func cancelPressed(sender: AnyObject) {
        
        if (newOrupdate == "New"){
            
        } else {
            let isPresentingInAddMadLibMode = presentingViewController is UINavigationController
        
            if isPresentingInAddMadLibMode {
                dismissViewControllerAnimated(true, completion: nil)
            
            } else {
                navigationController!.popViewControllerAnimated(true)
            }
        }
        
        
        
    }
    //END OF FUNC cancelPressed

    //FUNC: popAlert(): Display an Alrt Box
    func popAlert(typeOfAlert: String, errorString: String) {
        let alertController = UIAlertController(title: typeOfAlert, message: errorString, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    //END OF FUNC: popAlert()
    
    
}
//END OF CLASS: PML_ResultsController