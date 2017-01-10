//
//  constants.swift
//  job_Search_App
//
//  Created by Anthony on 12/20/16.
//  Copyright © 2016 Anthony. All rights reserved.
//

import Foundation
import UIKit

let storageRoot = "gs://jobsearchapp-24a3d.appspot.com"

let firstChild = "/contactsFolder/"

let childFile = "contactstestdata.csv"

//let firebaseStorageTestJson = "https://firebasestorage.googleapis.com/v0/b/jobsearchapp-24a3d.appspot.com/o/contactsFolder%2FtestProperty.json?alt=media&token=f50891e2-a3a1-493c-a3ec-ee8edb293d33"

let firebaseStorageTestJson = "https://firebasestorage.googleapis.com/v0/b/jobsearchapp-24a3d.appspot.com/o/contactsFolder%2FtestPropertyShort.json?alt=media&token=a988194e-d27d-4830-ba01-17d7c4359cd6"

let hunterAPIkey = "5fe55320e40bcccebccd0dd88059a606e7baeadf"

///Get every email address found on the internet using a given domain name, with sources.

let hunterAPIkeyDOMAIN_Search = ("https://api.hunter.io/v2/domain-search?domain=stripe.com&api_key=\(hunterAPIkey)")

///Find the email address of someone from his first name, last name and domain name.

let hunterAPIkeyFirst_Last_Domain_Search = ("https://api.hunter.io/v2/email-finder?domain=asana.com&first_name=Dustin&last_name=Moskovitz&api_key=\(hunterAPIkey)")

///Check if a given email address is deliverable and has been found on the internet.

let hunterAPIkeyValidation = ("https://api.hunter.io/v2/email-verifier?email=steli@close.io&api_key=\(hunterAPIkey)")

extension UIViewController {
    
    func createGradientLayer(on: UIView) {
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = on.bounds
        
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.black.cgColor]
        
        on.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    func setupNavBar(bar: UINavigationBar, text: String) {
        
        let borderSize: CGFloat = 1.0 // what ever border width do you prefer
        
        
        let bottomLine = CALayer()
        
            bottomLine.frame = CGRect(x: 0, y: 43, width: 1000, height: borderSize)
           
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
        
        
        
        /// there is an image subview attached to the titleText so we can add independant background images to each Nav bar in the future.
    }

    func createGlow(button: UIButton){
        
        button.titleLabel?.layer.shadowColor = button.currentTitleColor.cgColor
        
        button.titleLabel?.layer.shadowRadius = 3
        
        button.titleLabel?.layer.shadowOpacity = 0.3
        
        button.titleLabel?.layer.shadowOffset = CGSize.zero
        
        button.titleLabel?.layer.masksToBounds = false
    }
}

//extension UIViewController {
//    func rz_smoothlyDeselectRows(tableView: UITableView?) {
//        // Get the initially selected index paths, if any
//        let selectedIndexPaths = tableView?.indexPathsForSelectedRows ?? []
//        
//        // Grab the transition coordinator responsible for the current transition
//        if let coordinator = transitionCoordinator {
//            coordinator.animateAlongsideTransition(in: nil, animation: { (context) in
//                selectedIndexPaths.forEach {
//                    tableView?.deselectRowAtIndexPath($0, animated: context.isAnimated())
//                }
//            }, completion: { (context) in
//                if context.isCancelled() {
//                    selectedIndexPaths.forEach {
//                        tableView?.selectRowAtIndexPath($0, animated: false, scrollPosition: .None)
//                    }
//                }
//            })
//                    } else { // If this isn't a transition coordinator, just deselect the rows without animating
//            selectedIndexPaths.forEach {
//                tableView?.deselectRow(at: $0, animated: false)
//            }
//        }
//    }
//}

