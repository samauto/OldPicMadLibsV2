//
//  PML_TableViewController.swift
//  PicMadLibs
//
//  Created by Mac on 5/19/16.
//  Copyright © 2016 STDESIGN. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class PML_TableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var madLists = [MadLib]()
    
    
    // MARK; PROPERTIES
    var madlibs = [MadLib]()
    var nounphoto = [Noun]()
    var verbphoto = [Verb]()
    var adverbphoto = [Adverb]()
    var adjectivephoto = [Adjective]()
    
    
    // MARK: CORE DATA ShareContext
    lazy var sharedContext: NSManagedObjectContext = {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }()
    
    
    // MARK: VIEW
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Left Side: Use the edit button item provided by the table view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        // Right Side: Use the edit button item provided by the table view controller.
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(PML_TableViewController.addMadLib))
        
        // Loads the PicMadLibs
        if let savedPicMadLibs = loadMadLibs() {
            madLists += savedPicMadLibs
        } else {
            loadSampleMadLibs()
        }
        
    }//END OF FUNC viewDidLoad
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
    }//END OF FUNC viewWillAppear

    
    
    //MARK: CORE DATA: Fetch PicMadLibs
    
    func loadMadLibs() -> [MadLib]? {
        
        // Create the Fetch Request
        let fetchRequest = NSFetchRequest(entityName: "MadLib")
        var savedMadLibs = [MadLib]()
        
        // Execute the Fetch Request
        do {
            savedMadLibs = try sharedContext.executeFetchRequest(fetchRequest) as! [MadLib]
        } catch {
            print ("Problem with retrieving MadLibs from Core Data!")
        }
        
        return savedMadLibs
        
    }//END OF FUNC: loadMadLibs()
    

    // MARK: Sample Data
    
    func loadSampleMadLibs() {
        let label1:String = "test1"
        let label2:String = "test2"
        let label3:String = "test3"
        
        let tf1 = MadLib(madID: label1, context: self.sharedContext)
        print ("tf1",tf1)
        let tf2 = MadLib(madID: label2, context: self.sharedContext)
        let tf3 = MadLib(madID: label3, context: self.sharedContext)
        
        print ("tf2",tf2)
        print ("tf3",tf3)
        
        madLists += [tf1, tf2, tf3]
        
        print("madtf",madLists)
    
    }//END OF FUNC loadSampleTFs

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: TableView Datasource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
        
    }//END OF FUNC tableView numberOfSectionsInTableView
   
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return madLists.count
        
    }//END OF FUNC tableView numberOfRowsInSection
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Fetches the appropriate madlib for the data source layout.
        let madList = madLists[indexPath.row]
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MadLibsTableCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MadLibsTableCell
        
        
        cell.PML_Title.text = madList.madlibID as String
        cell.NounPhoto.image = UIImage(named:"Generate")
        cell.VerbPhoto.image = UIImage(named:"Generate")
        cell.AdverbPhoto.image = UIImage(named:"Generate")
        cell.AdjectivePhoto.image = UIImage(named:"Generate")
        
        return cell
        
    }//END OF FUNC tableView cellForRowAtIndexPath
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let controller = storyboard!.instantiateViewControllerWithIdentifier("PML_ResultsController") as! PML_ResultsController
        
        //controller.actor = actors[indexPath.row]
        
        self.navigationController!.pushViewController(controller, animated: true)
        
    }//END OF FUNC tableView didSelectRowAtIndexPath
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        
        switch (editingStyle) {
        case .Delete:
            // Delete the row from the data source
            madLists.removeAtIndex(indexPath.row)
            // Save the madlibs after the Delete
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        default:
            break
            // Remove the madlib from the context
            //sharedContext.deleteObject(madlib)
            //CoreDataStackManager.sharedInstance().saveContext()
        }
        
    }//END OF FUNC tableView commitEditingStyle
 
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }//END OF FUNC tableView canEditRowAtIndexPath
    
    
    // MARK: Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    /*
        if segue.identifier == "ShowDetail" {
            let madlibDetailViewController = segue.destinationViewController as! PML_FormController
            // Get the cell that generated this segue.
            if let selectedMadlibCell = sender as? MadLibsTableCell {
                let indexPath = tableView.indexPathForCell(selectedMadlibCell)!
                let selectedMadlib = madLists[indexPath.row]
                madlibDetailViewController.madLists = selectedMadlib
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new madlib.")
        }
 
    */
    }//END OF FUNC prepareForSegue
    
    
    @IBAction func unwindToMadLibList(sender: UIStoryboardSegue) {
    /*
        if let sourceViewController = sender.sourceViewController as? PML_FormController,
            madlibL = sourceViewController.madLists{
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                madLists[selectedIndexPath.row] = madlibL
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                // Add a new transformer
                let newIndexPath = NSIndexPath(forRow: madLists.count, inSection: 0)
                madLists.append(madlibL)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            // Save the transformers after the Edits
            saveMadLibs()
        }
    */
    }//END OF FUNC unwindToMealList
    
    
    
    // MARK: NSCoding
    

    /*
     
     
     // MARK: - Core Data Convenience. This will be useful for fetching. And for adding and saving objects as well.
     
     lazy var sharedContext: NSManagedObjectContext = {
     return CoreDataStackManager.sharedInstance().managedObjectContext
     }()

     
             
             
     
     override func viewWillAppear(animated: Bool) {
     super.viewWillAppear(animated)
     
     tableView.reloadData()
     }//END OF FUNC: viewWillAppear
     
             
             override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
             // let controller = storyboard!.instantiateViewControllerWithIdentifier("PML_ResultsController") as! PML_ResultsController
             
             // controller.madlib = madlibs[indexPath.row]
             
             // self.navigationController!.pushViewController(controller, animated: true)
             }
     
     func addMadLib() {
     let alertController = UIAlertController (title: "Alert Title", message:"Type....", preferredStyle: UIAlertControllerStyle.Alert)
     let confirmAction = UIAlertAction(title: "Confirm title", style: UIAlertActionStyle.Default, handler: ({
     (_) in
     if let field = alertController.textFields![0] as? UITextField {
     self.saveMadLib(field.text!)
     self.tableView.reloadData()
     }
     }
     ))
     
     let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
     
     alertController.addTextFieldWithConfigurationHandler({
     (textfield) in
     textfield.placeholder = "Type in something!!!"
     })
     
     alertController.addAction(confirmAction)
     alertController.addAction(cancelAction)
     
     self.presentViewController(alertController, animated: true, completion: nil)
     }
     
     
     func saveMadLib(itemToSave: String) {
     let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
     
     let managedContext = appDelegate.managedObjectContext
     
     let entity = NSEntityDescription.entityForName("MadLibItems", inManagedObjectContext: managedContext)
     
     let item = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:managedContext)
     
     do {
     try managedContext.save()
     
     madList.append(item)
     }
     catch {
     print("error")
     }
     }
     */
    
    
    
}//END OF CLASS: PML_TableViewController