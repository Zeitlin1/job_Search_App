//
//  ManagerViewController.swift
//  job_Search_App
//
//  Created by Anthony on 12/29/16.
//  Copyright © 2016 Anthony. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage


class DashboardViewController: UIViewController {
    
    let central = CentralDataStore.shared

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
//
//    
//    func uploadCSV() {
//        
//        // Create a reference to local data source file
//        if let uploadFile = URL(string: firebaseStorageTestJson) {
//        
//        // Create a root reference
//        let storageRef = storage.reference()
//        
//        // Create a reference to the root's child
//        let child = storageRef.child(firstChild)
//       
//        
//            let uploadTask = child.putFile(uploadFile)
////            if let error = error {
////             
////                print(error)
////                print("ERROR")
////            } else {
////                // Metadata contains file metadata such as size, content-type, and download URL.
////                let downloadURL = metadata!.downloadURL()
////                print(downloadURL?.absoluteString)
////                print("NO ERROR")
////            }
////        }
//        }
//    }
//    
//

    @IBAction func loadLeadsButton(_ sender: Any) {
        central.populateCentralArray()
    }
    
    @IBAction func uploadLeadsButton(_ sender: Any) {
        central.getBusinessDataFromApi { 
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }
    }
    
    
    
}
