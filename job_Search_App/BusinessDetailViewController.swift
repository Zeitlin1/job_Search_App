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
        if business.warmLead == true {
            callSwitchLabel.isOn = true
            print("CALL SWITCH SET TO ON")
        } else { callSwitchLabel.isOn = false }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        business.notes = notesTextView.text
    }
    
//    func drawRect(rect: CGRect) {
//        
//        // Get the current drawing context
//        
//        let context: CGContext = UIGraphicsGetCurrentContext()!
//    
//    
//        // Set the line color and width
//        
//        context.setStrokeColor(UIColor(red:0.0, green:0.0, blue:0.0, alpha:0.2).cgColor)
//        
//        context.setLineWidth(1.0);
//        // Start a new Path
//        
//        context.beginPath()
//     
//        //Find the number of lines in our textView + add a bit more height to draw lines in the empty part of the view
//        
//        let numberOfLines = (notesTextView.contentSize.height + notesTextView.bounds.size.height) / notesTextView.font!.lineHeight
//        
//        // Set the line offset from the baseline.
//        
//        let baselineOffset:CGFloat = 5.0
//        
//        
//        
//        // Iterate over numberOfLines and draw a line in the textView
//        
//        for x in 1 ..< Int(numberOfLines) {
//            
//            //0.5f offset lines up line with pixel boundary
//            context.move(context, notesTextView.bounds.origin.x, notesTextView.font!.lineHeight * CGFloat(x) + baselineOffset)
//            
//            
//            context.addLine(to: context, CGFloat(notesTextView.bounds.size.width), notesTextView.font!.lineHeight * CGFloat(x) + baselineOffset)
//            
//        }
//        
//        //Close our Path and Stroke (draw) it
//        
//        context.closePath()
//        
//        context.strokePath()
//        
//    }

    
    @IBAction func callSwitch(_ sender: Any) {
        if business.warmLead == true {
            business.warmLead = false
        } else if business.warmLead == false {
            business.warmLead = true
        }
        print("Warm Lead Activated")
    }
    
    @IBAction func callButtonPushed(_ sender: Any) {
        
        if let url = URL(string: "tel://\(business.number!)") {
            print("Calling \(business.number!)")
            UIApplication.shared.open(url, options: [:], completionHandler: { (true) in
                self.business.callDate = NSDate()
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = DateFormatter.Style.medium
                self.lastCallDateText.text = String(describing: dateFormatter.string(from: self.business.callDate as! Date))
                self.business.numberOfCallsTo += 1
                self.callCountText.text = String(describing: self.business.numberOfCallsTo)
                print(self.business.numberOfCallsTo)
                
                })

        }
    }
    
    
}
