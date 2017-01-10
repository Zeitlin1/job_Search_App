//
//  LeadDetailViewController.swift
//  job_Search_App
//
//  Created by Anthony on 12/23/16.
//  Copyright © 2016 Anthony. All rights reserved.
//

import UIKit
import CoreData
import Foundation
import Firebase

class LeadDetailViewController: UIViewController {

    var lead: Property!
    
    let central = CentralDataStore.shared
    
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
    @IBOutlet weak var callButtonLabel: UIButton!
    @IBOutlet weak var deleteLeadButtonLabel: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleText = "Details"
        
        let nav = self.navigationController?.navigationBar
        
        setupNavBar(bar: nav!, text: titleText)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(PropertyDetailViewController.dismissKeyboard))
        
        self.view.addGestureRecognizer(tap)
        
        self.view.backgroundColor = UIColor.clear
        
        self.view.addSubview(deleteLeadButtonLabel)
        
        setLead()
        
        createGradientLayer(on: self.view)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
            notesTextView.text = lead.notes
            
            callCountText.text = String(describing: lead.numberOfCallsTo)
            
            self.lastCallDateText.text = lead.callDate
        }
        
        
        
    
    
    func dismissKeyboard() {
        
        lead.notes = notesTextView.text
        
        view.endEditing(true)
    }
    
    
    @IBAction func deleteLeadButton(_ sender: Any) {
        
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to delete your saved lead?", preferredStyle: UIAlertControllerStyle.alert)
        
        let delete = UIAlertAction(title: "Delete", style: UIAlertActionStyle.default) { completion -> Void in
            
            self.lead.warmLead = false
            
            self.central.updateFirebaseProperty(property: self.lead)
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setPropertyCold"), object: nil) /// see if this observer sets the thingy off
            
            self.navigationController!.popViewController(animated: true)
                
            }
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) { completion -> Void in
            self.lead.warmLead = true
        }
        
        alertController.addAction(delete)
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true, completion: {
        })
    
    }

    
    @IBAction func callButtonPushed(_ sender: Any) {
        
        if let phoneNumber = Int(lead.contactPhone!), let url = URL(string: "tel://\(phoneNumber)") {
            
            if #available(iOS 10, *) {

            print("Calling \(lead.contactPhone!)")
            
            UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                
                if success == true {
                self.lead.callDate = self.currentDateToString()
                
                self.lastCallDateText.text = self.lead.callDate
                
                self.lead.numberOfCallsTo += 1
                
                self.callCountText.text = String(describing: self.lead.numberOfCallsTo)
             
                }
                
            })}
            else {
            let success = UIApplication.shared.openURL(url)
                if success == true {
                self.lead.callDate = self.currentDateToString()
                
                self.lastCallDateText.text = self.lead.callDate
                
                self.lead.numberOfCallsTo += 1
                
                self.callCountText.text = String(describing: self.lead.numberOfCallsTo)
                
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
      
         lead.notes = notesTextView.text
        central.updateFirebaseProperty(property: lead)
        

    }
    
    func setLead() {
        
        businessNameLabel.text = lead.buildingAddress
        callCountText.text = String(describing: lead.numberOfCallsTo)
        contactLabel.text = lead.contactPhone
        industryLabel.text = lead.construction
        lastCallDateText.text = String(describing: self.lead.callDate)
        notesTextView.text = lead.notes
        
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
            callNotesLabel.textColor = UIColor.lightGray
            
        }
        
        notesTextView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.left.equalTo(self.view)
            make.width.equalTo(self.view)
            make.top.equalTo(callNotesLabel).offset(20)
            make.height.equalTo(275)
//            notesTextView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
            notesTextView.textColor = UIColor.white
            notesTextView.layer.borderColor = UIColor.white.cgColor
            notesTextView.layer.borderWidth = 2
            
        }
        
        deleteLeadButtonLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view).multipliedBy(1.5)
            make.bottom.equalTo(notesTextView).offset(80)
            make.width.equalTo(75)
            make.height.equalTo(50)
            deleteLeadButtonLabel.layer.cornerRadius = 5
            deleteLeadButtonLabel.backgroundColor = UIColor.red
            deleteLeadButtonLabel.layer.borderColor = UIColor.black.cgColor
            deleteLeadButtonLabel.layer.borderWidth = 2
            deleteLeadButtonLabel.titleLabel?.textColor = UIColor.black
            
        }
        
        callButtonLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view).multipliedBy(0.5)
            make.bottom.equalTo(deleteLeadButtonLabel)
            make.width.equalTo(75)
            make.height.equalTo(50)
            callButtonLabel.layer.cornerRadius = 5
            callButtonLabel.backgroundColor = UIColor.green
            callButtonLabel.layer.borderColor = UIColor.blue.cgColor
            callButtonLabel.layer.borderWidth = 2
            callButtonLabel.titleLabel?.textColor = UIColor.blue
        }
    }
    
    func currentDateToString() -> String {
        
        let callDate = NSDate()
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        return String(describing: dateFormatter.string(from: callDate as Date))
    }

}
