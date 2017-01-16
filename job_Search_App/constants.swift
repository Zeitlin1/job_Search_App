//
//  constants.swift
//  job_Search_App
//
//  Created by Anthony on 12/20/16.
//  Copyright © 2016 Anthony. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

let storageRoot = "gs://jobsearchapp-24a3d.appspot.com"

let firstChild = "/contactsFolder/"

let childFile = "contactstestdata.csv"

//let firebaseStorageTestJson = "https://firebasestorage.googleapis.com/v0/b/jobsearchapp-24a3d.appspot.com/o/contactsFolder%2FtestProperty.json?alt=media&token=f50891e2-a3a1-493c-a3ec-ee8edb293d33"

let firebaseStorageTestJson = "https://firebasestorage.googleapis.com/v0/b/jobsearchapp-24a3d.appspot.com/o/contactsFolder%2FtestPropertyShort.json?alt=media&token=a988194e-d27d-4830-ba01-17d7c4359cd6"

let hunterAPIkey = "5fe55320e40bcccebccd0dd88059a606e7baeadf"

///Get every email address found on the internet using a given domain name, with sources.
let hunterBaseURL = ("https://api.hunter.io/v2/")

///Find the email address of someone from his first name, last name and domain name.

let hunterAPIkeyFirst_Last_Domain_Search = ("https://api.hunter.io/v2/email-finder?domain=asana.com&first_name=Dustin&last_name=Moskovitz&api_key=\(hunterAPIkey)")

///Check if a given email address is deliverable and has been found on the internet.

let hunterAPIkeyValidation = ("https://api.hunter.io/v2/email-verifier?email=steli@close.io&api_key=\(hunterAPIkey)")

extension UIViewController {
    
    func createGradientLayer(on: UIView) {
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = on.bounds
        
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.black.cgColor]
        
//        gradientLayer.colors = [UIColor.white.cgColor, UIColor.orange.cgColor]
        
        on.layer.insertSublayer(gradientLayer, at: 0)
        
    }

    
    func setupNavBar(bar: UINavigationBar, text: String) {
        
        let borderSize: CGFloat = 1.0 // what ever border width do you prefer
        
        
        let bottomLine = CALayer()
        
            bottomLine.frame = CGRect(x: 0, y: 43, width: bar.frame.width, height: borderSize)
        
        print(bar.accessibilityFrame.width)
           
            bottomLine.backgroundColor = UIColor.red.cgColor
           
            bar.layer.addSublayer(bottomLine)
            
            bar.layer.masksToBounds = true
            
            bar.barStyle = UIBarStyle.blackTranslucent
       
        
        let titleTextLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
    
            titleTextLabel.textAlignment = .center
            
            titleTextLabel.textColor = UIColor.white
            
            titleTextLabel.text = text
        
        
        let titleImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        
            titleTextLabel.addSubview(titleImageView)
            
        
        navigationItem.titleView = titleTextLabel
        
        
//        let glowSpotSize = 1.0 // what ever border thickness you prefer
//        
//        let glowSpot = UILabel()
//        
//        glowSpot.frame = CGRect(x: -10, y: 40, width: 3, height: 10)
//
//        let lineColor = UIColor.red.withAlphaComponent(1)
//    
//        glowSpot.backgroundColor = lineColor
//        glowSpot.layer.backgroundColor = lineColor.cgColor
//        glowSpot.layer.borderColor = lineColor.cgColor
//        
//      
//        
////        bar.bringSubview(toFront: glowSpot)
//
//        bottomLine.masksToBounds = false
//        
//        createLabelGlow(label: glowSpot)
//        
//        bar.addSubview(glowSpot)
//        
//        bar.translatesAutoresizingMaskIntoConstraints = true 
//        bar.bringSubview(toFront: glowSpot)
//        
//        
////        glowSpot.layer.cornerRadius = 18
//        
//        UILabel.animate(withDuration: 10, delay: 0, options: [UIViewAnimationOptions.autoreverse, UIViewAnimationOptions.repeat, UIViewAnimationOptions.curveLinear] , animations: {
//            
//            glowSpot.frame = CGRect(x: -10, y: 40, width: 3, height: 10)
//            
//            glowSpot.frame = CGRect(x: (self.view.frame.width + 10), y: 40, width: 3, height: 10)
//            
//        }) { (nop) in
//            
//        }
    
    }
    
        
        /// there is an image subview attached to the titleText so we can add independant background images to each Nav bar in the future.
    
    func createLabelGlow(label: UILabel){
        
        label.layer.shadowColor = UIColor.yellow.cgColor
//            label.layer.backgroundColor
        
        label.layer.shadowRadius = 10
        
        label.layer.shadowOpacity = 1
        
        label.layer.shadowOffset = CGSize.zero
        
        label.layer.masksToBounds = false
    }
    

    func createGlow(button: UIButton){
        
        button.titleLabel?.layer.shadowColor = button.currentTitleColor.cgColor
        
        button.titleLabel?.layer.shadowRadius = 4
        
        button.titleLabel?.layer.shadowOpacity = 1
        
        button.titleLabel?.layer.shadowOffset = CGSize.zero
        
        button.titleLabel?.layer.masksToBounds = false
    }
    

}
