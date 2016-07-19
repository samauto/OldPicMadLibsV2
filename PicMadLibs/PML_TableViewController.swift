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
    
    // MARK: PROPERTIES
    
    // MadLibs Array
    var madLists = [MadLib]()
    
    // Label to notify that there is no PicMadLibs on the list
    var noPicMadLibsLabel: UILabel!
    
    
    // MARK: CORE DATA ShareContext
    
    lazy var sharedContext: NSManagedObjectContext = {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }()

    
    // MARK: VIEW
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Label to notify that there is no PicMadLibs on the list
        noPicMadLibsLabel = UILabel(frame: CGRectMake(0,0,tableView.bounds.size.width,tableView.bounds.size.height))
        noPicMadLibsLabel.text = "No PicMadLibs available. \nAdd one with the + button."
        noPicMadLibsLabel.textAlignment = NSTextAlignment.Center
        noPicMadLibsLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        noPicMadLibsLabel.numberOfLines = 2
        noPicMadLibsLabel.sizeToFit()
        noPicMadLibsLabel.font = UIFont(name: "HelveticaNeue", size: 25)!
        tableView.backgroundView = noPicMadLibsLabel
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        // Left Side: Use the edit button item provided by the table view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        // Loads the PicMadLibs
        if let savedPicMadLibs = loadMadLibs() {
            madLists += savedPicMadLibs
        }
        
    }//END OF FUNC viewDidLoad
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: TableView Datasource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections
        return 1
        
    }//END OF FUNC tableView numberOfSectionsInTableView
   
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (madLists.count > 0) {
            noPicMadLibsLabel.hidden = true
        }
        else {
            noPicMadLibsLabel.hidden = false
        }
        // Return the number of rows
        return madLists.count
        
    }//END OF FUNC tableView numberOfRowsInSection
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MadLibsTableCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MadLibsTableCell
        
        // Fetches the appropriate madlib for the data source layout.
        let madList = madLists[indexPath.row]
        
        cell.PML_Title.text = madList.madlibID as String
        cell.NounPhoto.image = UIImage(named:"Generate")
        cell.VerbPhoto.image = UIImage(named:"Generate")
        cell.AdverbPhoto.image = UIImage(named:"Generate")
        cell.AdjectivePhoto.image = UIImage(named:"Generate")
        
        return cell
        
    }//END OF FUNC tableView cellForRowAtIndexPath
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
        
    }//END OF FUNC tableView canEditRowAtIndexPath

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        switch (editingStyle) {
            
        case .Delete:
            // Remove the PicMadlIb from the context
            sharedContext.deleteObject(madLists[indexPath.row])
            madLists.removeAtIndex(indexPath.row)
            CoreDataStackManager.sharedInstance().saveContext()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        default:
            break
        }
        
    }//END OF FUNC tableView commitEditingStyle


    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //DEBUG print ("SEGUE", segue.identifier)
        
        if segue.identifier == "DetailsPML" {
            let madlibDetail = segue.destinationViewController as! PML_ResultsController
    
            // Get the cell that generated this segue.
            if let detailsMadlibCell = sender as? MadLibsTableCell {
                let indexPath = tableView.indexPathForCell(detailsMadlibCell)!
                let detailsMadlib = madLists[indexPath.row]
                madlibDetail.selMadList = detailsMadlib
                print("Show Details of madlib")
            }
        }
        
        else if segue.identifier == "UpdatePML" {
            let madlibUpdate = segue.destinationViewController as! PML_FormController
            
            // Get the cell that generated this segue.
            if let selectedMadlibCell = sender as? MadLibsTableCell {
                let indexPath = tableView.indexPathForCell(selectedMadlibCell)!
                let selectedMadlib = madLists[indexPath.row]
                madlibUpdate.madList = selectedMadlib
                print("Update the madlib")
            }
        }
        else if segue.identifier == "AddPML" {
            print("Adding new madlib.")
        }
 
    }//END OF FUNC prepareForSegue
    
    
    @IBAction func unwindToMadLibList(sender: UIStoryboardSegue) {

        if let sourceViewController = sender.sourceViewController as? PML_FormController, madList = sourceViewController.madList {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // DEBUG: print("UNWIND")
                // Update an existing PicMadLib
                madLists[selectedIndexPath.row] = madList
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                // Add a new PicMadLib
                let newIndexPath = NSIndexPath(forRow: madLists.count, inSection: 0)
                madLists.append(madList)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            CoreDataStackManager.sharedInstance().saveContext()
        }

    }//END OF FUNC unwindToMealList
    
    
    //MARK: CORE DATA: Fetch PicMadLibs
    
    func loadMadLibs() -> [MadLib]? {
        
        // Create the Fetch Request
        let fetchRequest = NSFetchRequest(entityName: "MadLib")
        
        // Execute the Fetch Request
        var savedMadLibs = [MadLib]()
        do {
            savedMadLibs = try sharedContext.executeFetchRequest(fetchRequest) as! [MadLib]
        } catch {
            print ("Problem with retrieving PicMadLibs from Core Data!")
        }
        return savedMadLibs
        
    }//END OF FUNC: loadMadLibs()
    
}//END OF CLASS: PML_TableViewController