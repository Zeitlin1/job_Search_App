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

class SavedLeadDetailViewController: UIViewController {
    
    let central = CentralDataStore.shared
    
    var lead: Property!
    
    let emailMaxReturn = 3
    
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
    @IBOutlet weak var emailText: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        notesTextView.autocorrectionType = .no
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.lead = central.currentProperty
        
        let titleText = "Details"
        
        let nav = self.navigationController?.navigationBar
        
        setupNavBar(bar: nav!, text: titleText)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(PropertyDetailViewController.dismissKeyboard))
        
        self.view.addGestureRecognizer(tap)
        
        self.view.backgroundColor = UIColor.clear
        
        self.view.addSubview(deleteLeadButtonLabel)
        
        setLead()
        
        createGradientLayer(on: self.view)
        
        self.automaticallyAdjustsScrollViewInsets = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
/// test this!
        if self.lead.parcelID == central.currentProperty?.parcelID {
        
            self.lead = central.currentProperty
        
        }
            notesTextView.text = lead?.notes
            
            callCountText.text = String(describing: lead.numberOfCallsTo)
            
            self.lastCallDateText.text = lead?.callDate
        }
    
    
    func dismissKeyboard() {
        
        lead?.notes = notesTextView.text
        
        view.endEditing(true)
    }
    
    
    @IBAction func deleteLeadButton(_ sender: Any) {
        
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to delete your saved lead?", preferredStyle: UIAlertControllerStyle.alert)
        
        let delete = UIAlertAction(title: "Delete", style: UIAlertActionStyle.default) { completion -> Void in
            
            self.lead?.warmLead = false
            
            self.central.updateFirebaseProperty(property: self.lead!)
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setPropertyCold"), object: nil) /// see if this observer sets the thingy off
            
            self.navigationController!.popViewController(animated: true)
                
            }
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) { completion -> Void in
            self.lead?.warmLead = true
        }
        
        alertController.addAction(delete)
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true, completion: {
        })
    
    }

    
    @IBAction func callButtonPushed(_ sender: Any) {
        
        if let phoneNumber = Int((lead?.contactPhone!)!), let url = URL(string: "tel://\(phoneNumber)") {
            
            if #available(iOS 10, *) {

            print("Calling \(lead?.contactPhone!)")
            
            UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                
                if success == true {
                self.lead?.callDate = self.currentDateToString()
                
                self.lastCallDateText.text = self.lead?.callDate
                
                self.lead?.numberOfCallsTo += 1
                
                self.callCountText.text = String(describing: self.lead?.numberOfCallsTo)
             
                }
                
            })}
            else {
            let success = UIApplication.shared.openURL(url)
                if success == true {
                self.lead?.callDate = self.currentDateToString()
                
                self.lastCallDateText.text = self.lead?.callDate
                
                self.lead?.numberOfCallsTo += 1
                
                self.callCountText.text = String(describing: self.lead?.numberOfCallsTo)
                
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
      central.currentProperty = self.lead
        
        print("Central Property set to self Saved")
        
        lead?.notes = notesTextView.text
        
        central.updateFirebaseProperty(property: lead!)
        

    }
    
    func setLead() {
        
        businessNameLabel.text = lead.buildingAddress
        callCountText.text = String(describing: lead.numberOfCallsTo)
        contactLabel.text = lead.contactPhone
        industryLabel.text = lead.construction
        notesTextView.text = lead.notes
        
        lastCallDateText.text = String(describing: self.lead.callDate)
        if lastCallDateText.text == "Ready" {
            lastCallDateText.textColor = UIColor.green
        } else {
            lastCallDateText.textColor = UIColor.white
        }
        
        var counter = 0
        
        var emailString = "No Emails Found"
        
        if (self.lead?.emails.count)! > 0 {
            
            for i in (self.lead?.emails)! {
            
                while self.emailMaxReturn > counter {
                
                emailString = ""
                
                emailString += (i + " ")
                
                counter += 1
                
                }
            }
        }
        
        emailText.text = emailString
        
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
//            make.right.equalTo(self.view).multipliedBy(0.95)
//            make.centerY.equalTo(self.view).multipliedBy(0.45)
            make.left.equalTo(self.view).offset(20)
            make.top.equalTo(callCountLabel.snp.bottom)
            
        }
        
        contactNumberLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(10)
            make.centerY.equalTo(self.view).multipliedBy(0.57)
        }
        
        contactLabel.snp.makeConstraints { (make) in
//            make.right.equalTo(self.view).multipliedBy(0.95)
            make.left.equalTo(self.view).offset(20)
//            make.centerY.equalTo(self.view).multipliedBy(0.57)
            make.top.equalTo(contactNumberLabel.snp.bottom)
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
//            make.centerY.equalTo(self.view).multipliedBy(0.7)
            make.top.equalTo(lastCalledDateLabel.snp.bottom)
            make.width.equalTo(150)
//            make.right.equalTo(self.view).multipliedBy(0.95)
            make.left.equalTo(self.view).offset(20)
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
        
        emailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(callCountLabel.snp.top)
            make.right.equalTo(self.view)
            make.width.equalTo(75)
            
            
            
        }
        
        emailText.snp.makeConstraints { (make) in
            make.top.equalTo(emailLabel.snp.bottom)
            make.right.equalTo(self.view).offset(-10)
            make.width.equalTo(250)
            make.height.equalTo(100)
            emailText.numberOfLines = emailMaxReturn
            
        }
        
    }
    
    func currentDateToString() -> String {
        
        let callDate = NSDate()
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        return String(describing: dateFormatter.string(from: callDate as Date))
    }

}
