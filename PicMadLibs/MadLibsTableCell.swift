//
//  MadlibTableCell.swift
//  PicMadLibs
//
//  Created by Mac on 5/19/16.
//  Copyright © 2016 STDESIGN. All rights reserved.
//

import Foundation
import UIKit

class MadLibsTableCell: UITableViewCell {
    
    
    @IBOutlet weak var NounPhoto: UIImageView!
    @IBOutlet weak var VerbPhoto: UIImageView!
    @IBOutlet weak var AdverbPhoto: UIImageView!
    @IBOutlet weak var AdjectivePhoto: UIImageView!
    @IBOutlet weak var PML_Title: UILabel!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    
}//END OF CLASS MadLibsTableCell
