//
//  ViewController.swift
//  PicMadLibs
//
//  Created by Mac on 5/18/16.
//  Copyright © 2016 STDESIGN. All rights reserved.
//

import UIKit

class PML_FormController: UIViewController {

    
    // MARK: PROPERTIES
    
    
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

    @IBAction func generatePressed(sender: AnyObject) {
    }
    
    
    //FUNC: prefare for Seque
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let formResults: PML_ResultsController = segue.destinationViewController as? PML_ResultsController {
            //formResults.inputNoun = self.userFN
            //formResults.inputVerb = self.userID
            //formResults.inputAdverb = self.userLoc
            //formResults.inputAdjective = self.userLink
        }
    }//END OF SEQUE

    
    

}//END OF CLASS: PML_FormController

