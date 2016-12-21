//
//  BusinessDetailViewController.swift
//  job_Search_App
//
//  Created by Anthony on 12/20/16.
//  Copyright © 2016 Anthony. All rights reserved.
//

import UIKit
import Foundation
import SnapKit
import CoreData

class BusinessDetailViewController: UIViewController {

    var business: Business!
    
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var industryLabel: UILabel!
    @IBOutlet weak var lastCalledDateLabel: UILabel!
    @IBOutlet weak var lastCallDateText: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var callNotesLabel: UILabel!
    
    @IBOutlet weak var calledLabel: UILabel!
    @IBOutlet weak var callSwitchLabel: UISwitch!
    @IBOutlet weak var noLabel: UILabel!
    @IBOutlet weak var yesLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(callSwitchLabel)
        self.callSwitchLabel.addSubview(notesTextView)
        self.callSwitchLabel.addSubview(calledLabel)
        self.callSwitchLabel.addSubview(noLabel)
        self.callSwitchLabel.addSubview(yesLabel)

        businessNameLabel.text = business.name
        addressLabel.text = business.addressZip
        contactLabel.text = business.number
        industryLabel.text = business.classification
        lastCallDateText.text = "April 1, 2016"
        notesTextView.text = "Place Holder content goes here."
        
        businessNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.width.equalTo(self.view)
            make.centerY.equalTo(self.view).multipliedBy(0.3)
            make.left.equalTo(self.view).offset(50)
        }
        
        addressLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view).multipliedBy(0.35)
            make.left.equalTo(self.view).offset(50)
        }
        
        contactLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view).multipliedBy(0.5)
        }
        
        industryLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view).multipliedBy(0.4)
        }
        
        lastCalledDateLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.view).multipliedBy(0.6)
            make.width.equalTo(150)
            make.left.equalTo(self.view).offset(30)
            
        }
        lastCallDateText.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.view).multipliedBy(0.6)
            make.width.equalTo(150)
            make.right.equalTo(self.view).offset(-30)
        }
        
        callNotesLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view).multipliedBy(0.7)
            
        }
        
        callSwitchLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-100)
            
        }
        
        calledLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(callSwitchLabel).offset(-30)
            make.centerX.equalTo(callSwitchLabel)
        }
        noLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(callSwitchLabel).offset(-7)
            make.left.equalTo(callSwitchLabel).offset(-28)
         
        }
        yesLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(callSwitchLabel).offset(-7)
            make.right.equalTo(callSwitchLabel).offset(35)
           
        }
        notesTextView.snp.makeConstraints { (make) in
           
            
        }
        
        
        
        
        // set constraints here
    }
    
    
    @IBAction func callSwitch(_ sender: Any) {
      
    }

}
