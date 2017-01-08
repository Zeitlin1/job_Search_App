//
//  LeadTableViewCell.swift
//  job_Search_App
//
//  Created by Anthony on 12/23/16.
//  Copyright © 2016 Anthony. All rights reserved.
//

import UIKit
import Foundation

class LeadTableViewCell: UITableViewCell {
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code 
//        print("lead cell awakening from NIB")
//    }
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        
//        // Configure the view for the selected state
//    }


    @IBOutlet weak var propertyNameText: UILabel!
    
    @IBOutlet weak var buffBarLabel: UILabel!
    
    @IBOutlet weak var addressText: UILabel!
    
    @IBOutlet weak var secondaryClassText: UILabel!
    
    @IBOutlet weak var callDateText: UILabel!

    @IBOutlet weak var ownerNameText: UILabel!
}
