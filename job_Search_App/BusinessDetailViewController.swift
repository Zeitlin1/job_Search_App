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
    
    let dateFormatter = DateFormatter()
    
    let store = CoreDataStack.shared
    
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var callCountLabel: UILabel!
    @IBOutlet weak var callCountText: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var industryLabel: UILabel!
    @IBOutlet weak var lastCalledDateLabel: UILabel!
    @IBOutlet weak var lastCallDateText: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var callNotesLabel: UILabel!
    @IBOutlet weak var contactNumberLabel: UILabel!
    @IBOutlet weak var calledLabel: UILabel!
    @IBOutlet weak var callSwitchLabel: UISwitch!
    @IBOutlet weak var noLabel: UILabel!
    @IBOutlet weak var yesLabel: UILabel!
    @IBOutlet weak var callButtonLabel: UIButton!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(BusinessDetailViewController.dismissKeyboard))
        
        self.view.addGestureRecognizer(tap)
        
        self.view.backgroundColor = UIColor.lightGray
        self.view.addSubview(callSwitchLabel)
        self.callSwitchLabel.addSubview(calledLabel)
        self.callSwitchLabel.addSubview(noLabel)
        self.callSwitchLabel.addSubview(yesLabel)

        businessNameLabel.text = business.name
        callCountText.text = String(describing: business.numberOfCallsTo)
        contactLabel.text = business.number
        industryLabel.text = business.classification
        lastCallDateText.text = String(describing: self.business.callDate)
        // use "DECEMBER 30, 2000" to test longest string used.
        notesTextView.text = business.notes
        
        businessNameLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view)
            make.centerY.equalTo(self.view).multipliedBy(0.26)
            
        }
        
        callCountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(10)
            make.centerY.equalTo(self.view).multipliedBy(0.45)
        }
        
        callCountText.snp.makeConstraints { (make) in
            make.right.equalTo(self.view).multipliedBy(0.95)
            make.centerY.equalTo(self.view).multipliedBy(0.45)
        }
        
        contactNumberLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(10)
            make.centerY.equalTo(self.view).multipliedBy(0.57)
        }
        
        contactLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.view).multipliedBy(0.95)
            make.centerY.equalTo(self.view).multipliedBy(0.57)
        }
        
        industryLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(businessNameLabel).offset(37)
        }
        
        lastCalledDateLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.view).multipliedBy(0.7)
            make.width.equalTo(140)
            make.left.equalTo(self.view).offset(10)
            
        }
        
        lastCallDateText.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.view).multipliedBy(0.7)
            make.width.equalTo(200)
            make.right.equalTo(self.view).multipliedBy(0.95)
        }
        
        callNotesLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view).multipliedBy(0.8)
            
        }
        
        notesTextView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.left.equalTo(self.view)
            make.width.equalTo(self.view)
            make.top.equalTo(callNotesLabel).offset(20)
            make.height.equalTo(275)
            
        }
        
        callSwitchLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view).multipliedBy(1.3)
            make.bottom.equalTo(notesTextView).offset(80)
            
        }
        
        calledLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(callSwitchLabel).offset(-33)
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
        
        callButtonLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(callSwitchLabel).offset(0)
            make.left.equalTo(callSwitchLabel).offset(-150)
            make.width.equalTo(callSwitchLabel).multipliedBy(1.5)
            make.height.equalTo(callSwitchLabel).multipliedBy(1.5)
            callButtonLabel.layer.cornerRadius = 5
            callButtonLabel.backgroundColor = UIColor.black
            callButtonLabel.layer.borderColor = UIColor.blue.cgColor
            callButtonLabel.layer.borderWidth = 2
            callButtonLabel.titleLabel?.textColor = UIColor.blue
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        notesTextView.text = business.notes
        
        if let callDate = business.callDate {
            
            dateFormatter.dateStyle = DateFormatter.Style.medium
            
            self.lastCallDateText.text = String(describing: dateFormatter.string(from: callDate as Date))
        
            } else { self.lastCallDateText.text = "Not Called" }
        
            if business.warmLead == true {
                
                callSwitchLabel.isOn = true
                
                print("CALL SWITCH SET TO ON")
            
            } else { callSwitchLabel.isOn = false }
    
    }
    
    func dismissKeyboard() {
        print("DISMISSING")
        view.endEditing(true)
   
    }
    

    
    @IBAction func callSwitch(_ sender: Any) {
        
        if business.warmLead == false {
            
            business.warmLead = true
            
            saveLead(leadName: business.name)
            
            print("Warm Lead Saved in CoreData")
        } else if business.warmLead == true {
            
            let alertController = UIAlertController(title: nil, message: "Are you sure you want to delete your saved lead?", preferredStyle: UIAlertControllerStyle.alert)
        
            let delete = UIAlertAction(title: "Delete", style: UIAlertActionStyle.default) { completion -> Void in
                print("Core data delete")
                self.callSwitchLabel.isOn = false
                self.business.warmLead = false
                
                // delete entry from coredata here
            }
            let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) { completion -> Void in
                print("Delete cancelled")
                self.callSwitchLabel.isOn = true
                self.business.warmLead = true
            }
            alertController.addAction(delete)
            alertController.addAction(cancel)
            
            self.present(alertController, animated: true, completion: {
                
            })
            
            
        }
    }
    
    func saveLead(leadName: String) {
        let managedContext = store.persistentContainer.viewContext
        
        let
        newLead = Lead(context: managedContext)
        print(leadName)
        newLead.name = leadName
        newLead.address = business.addressZip
        newLead.classification = business.classification
        newLead.contact = business.number
        newLead.timesCalled = Int16(business.numberOfCallsTo)
        newLead.lastCallDate = business.callDate
        newLead.notes = business.notes
        newLead.warmLead = business.warmLead
        
        do {
            try managedContext.save(); print(newLead)
        }catch{
             
        }
        
        
        
    }
    
    @IBAction func callButtonPushed(_ sender: Any) {
        
        if let url = URL(string: "tel://\(business.number!)") {
           
            print("Calling \(business.number!)")
            
            UIApplication.shared.open(url, options: [:], completionHandler: { (true) in
                
                self.business.callDate = NSDate()
                
                self.dateFormatter.dateStyle = DateFormatter.Style.medium
                
                self.lastCallDateText.text = String(describing: self.dateFormatter.string(from: self.business.callDate as! Date))
                
                self.business.numberOfCallsTo += 1
                
                self.callCountText.text = String(describing: self.business.numberOfCallsTo)
                
                print(self.business.numberOfCallsTo)

                })

        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        business.notes = notesTextView.text
        
    }
    
}
