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
import Firebase
import FirebaseDatabase
import CoreTelephony

class PropertyDetailViewController: UIViewController {
    
    let dateFormatter = DateFormatter()
    
    var central = CentralDataStore.shared
    
    var property: Property!

    var propCounter = 0
    
    let emailMaxReturn = 3
    
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var callCountLabel: UILabel!
    @IBOutlet weak var addressTextBox: UILabel!
    @IBOutlet weak var callCountText: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var lastCalledDateLabel: UILabel!
    @IBOutlet weak var lastCallDateText: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var callNotesLabel: UILabel!
    @IBOutlet weak var contactNumberLabel: UILabel!
    @IBOutlet weak var callSwitchLabel: UISwitch!
    @IBOutlet weak var noLabel: UILabel!
    @IBOutlet weak var yesLabel: UILabel!
    @IBOutlet weak var callButtonLabel: UIButton!
    @IBOutlet weak var emailText: UILabel!
    @IBOutlet weak var callNumberText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(self.startIndicator),name:NSNotification.Name(rawValue: "startPropIndicator"), object: nil)
//        
//        NotificationCenter.default.addObserver(self, selector: #selector(self.stopIndicator),name:NSNotification.Name(rawValue: "stopPropIndicator"), object: nil)
        
        
//        NotificationCenter.default.addObserver(self, selector: #selector(self.startTimer),name:NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.stopTimer),name:NSNotification.Name.UIApplicationWillEnterForeground, object: nil)

        notesTextView.autocorrectionType = .no
        
        self.property = central.currentProperty
        
        DispatchQueue.main.async {

            self.ActivityIndicator.startAnimating()
            
            let base = hunterBaseURL
            
            let domainText = self.property.ownerName!.components(separatedBy: .whitespaces).joined(separator: "")
            
            print("THIS IS GETTING SENT EMAILS - \(domainText)")
            
            let hunterAPIkeyDOMAIN_Search = ("\(base)domain-search?domain=\(domainText)&api_key=\(hunterAPIkey)")
            
            self.central.findEmailData(domain: hunterAPIkeyDOMAIN_Search, completion: { emails in
                
                self.ActivityIndicator.stopAnimating()
                self.ActivityIndicator.isHidden = true
                
                var emailCounter = 0
                
                var emailString = "No Emails Found"
                
                self.emailText.text = emailString
                
                if emails.count > 0 {
                    
                    self.central.currentProperty?.emails = emails
                    
                    for i in (self.central.currentProperty?.emails)! {
                        
                        if self.emailMaxReturn > emailCounter {
                            
                            emailString += i + "\n"
                            
                            emailCounter += 1
                            
                        }
                    }
                    
                    DispatchQueue.main.sync {
                        
                        self.emailText.text = emailString
                        
                    }
                    
                    self.central.updateFirebaseProperty(property: self.property!)

                }

            })
          
        }
        let titleText = "Details"
        
        let nav = self.navigationController?.navigationBar
        
        setupNavBar(bar: nav!, text: titleText)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.setPropertyCold),name:NSNotification.Name(rawValue: "setPropertyCold"), object: nil)
       
        self.view.backgroundColor = UIColor.clear
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(PropertyDetailViewController.dismissKeyboard))
        
        self.view.addGestureRecognizer(tap)

        createGradientLayer(on: self.view)
        
        self.automaticallyAdjustsScrollViewInsets = false

        setView()
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        if self.property.parcelID == central.currentProperty?.parcelID {
        
            self.property = central.currentProperty
        
        }

        if property.warmLead == true {

           callSwitchLabel.isOn = true

        } else if property.warmLead == false {

            callSwitchLabel.isOn = false
        }
        
        self.lastCallDateText.text = property.callDate
                if lastCallDateText.text != "Ready" {
                    lastCallDateText.textColor = UIColor.white
                } else {
                    lastCallDateText.textColor = UIColor.green
        }
        self.callCountText.text = String(describing: property.numberOfCallsTo)
            self.notesTextView.text = property.notes
        
        }
    
    func dismissKeyboard() {
        property.notes = notesTextView.text
       
        view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        central.currentProperty = self.property
        
        property.notes = notesTextView.text
        
        central.updateFirebaseProperty(property: property!)
               
    }
    
    @IBAction func callSwitch(_ sender: Any) {
        
        if property.warmLead == false {
            
                property.warmLead = true
            
                central.updateFirebaseProperty(property: property!)
                    
                callSwitchLabel.isOn = true
            
        } else if property.warmLead == true {
            
            let alertController = UIAlertController(title: nil, message: "Are you sure you want to set this lead to cold?", preferredStyle: UIAlertControllerStyle.alert)
        
            let delete = UIAlertAction(title: "Set Cold", style: UIAlertActionStyle.default) { completion -> Void in
                
                self.property.warmLead = false
                
                self.central.updateFirebaseProperty(property: self.property!)
                
                self.callSwitchLabel.isOn = false
                
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) { completion -> Void in
             
                self.callSwitchLabel.isOn = true
               
                self.property.warmLead = true
            }
            
                alertController.addAction(delete)
            
                alertController.addAction(cancel)
            
                self.present(alertController, animated: true, completion: {})
        }

    }
    
    
    @IBAction func callButtonPushed(_ sender: Any) {
        
        if let url = URL(string:  "tel://\(property.contactPhone!)") {
           if #available(iOS 10, *) {
            
            print("Calling \(property.contactPhone!)")
            
            UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                
                if success == true {
                    
                self.property.callDate = self.currentDateToString()
                
                self.lastCallDateText.text = self.property.callDate
                    
                self.lastCallDateText.textColor = UIColor.white
                
                self.property.numberOfCallsTo += 1
                
                self.callCountText.text = String(describing: self.property.numberOfCallsTo)
                
                }
                
            })} else {
            
            let success = UIApplication.shared.openURL(url)
            
                if success == true {
                
                self.property.callDate = self.currentDateToString()
                
                self.lastCallDateText.text = self.property.callDate
                    
                self.lastCallDateText.textColor = UIColor.white
                
                self.property.numberOfCallsTo += 1
                
                self.callCountText.text = String(describing: self.property.numberOfCallsTo)
                
                }
            }
            
        }

    }
    
    
    
    func setView() {
        self.view.backgroundColor = UIColor.white
        
        businessNameLabel.text = property.buildingAddress
        callCountText.text = String(describing: property.numberOfCallsTo)
        callNumberText.text = property.contactPhone
        lastCallDateText.text = String(describing: self.property.callDate)
        notesTextView.text = property.notes
        
        callNotesLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view).multipliedBy(0.8)
            
        }
        
        businessNameLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view)
            make.centerY.equalTo(self.view).multipliedBy(0.26)
            
        }

        
        notesTextView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.left.equalTo(self.view)
            make.width.equalTo(self.view)
            make.top.equalTo(callNotesLabel).offset(20)
            make.height.equalTo(275)
            notesTextView.textColor = UIColor.white
            notesTextView.layer.borderColor = UIColor.white.cgColor
            notesTextView.layer.borderWidth = 2
            
        }
        
        
        callSwitchLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view).multipliedBy(1.5)
            make.bottom.equalTo(notesTextView).offset(80)
            
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
            make.bottom.equalTo(callSwitchLabel)
            make.centerX.equalTo(self.view).multipliedBy(0.5)
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
    
    func setPropertyCold() {
        self.property.warmLead = false
    }
    
    func stopIndicator() {
        self.ActivityIndicator.stopAnimating()
        print("indicator stopped")
    }
    
    func startIndicator() {
        self.ActivityIndicator.startAnimating()
        print("indicator started")
    }
    
    
//    private func updateCallDurationTimer() {
//        let callCount = callManager?.calls.count ?? 0
//        
//        if callCount > 0 && callDurationTimer == nil {
//            callDurationTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(callDurationTimerFired), userInfo: nil, repeats: true)
//        } else if callCount == 0 && callDurationTimer != nil {
//            callDurationTimer?.invalidate()
//            callDurationTimer = nil
//        }
//    }
    
}

