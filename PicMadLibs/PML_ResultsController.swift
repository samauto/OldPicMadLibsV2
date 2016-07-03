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

class PML_ResultsController: UIViewController {

    // MARK: Variables
    
    var NounInput: String?
    var VerbInput: String?
    var AdverbInput: String?
    var AdjectiveInput: String?
    
    
    // MARK: VIEW
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("PML_Results noun", NounInput!)
        print("PML_Results verb", VerbInput!)
        print("PML_Results adverb", AdverbInput!)
        print("PML_Results adjective", AdjectiveInput!)
        
    }//END OF FUNC: viewDidLoad
    
}//END OF CLASS: PML_ResultsController