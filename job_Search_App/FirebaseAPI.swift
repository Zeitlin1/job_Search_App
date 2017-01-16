//
//  FirebaseAPI.swift
//  job_Search_App
//
//  Created by Anthony on 12/28/16.
//  Copyright © 2016 Anthony. All rights reserved.
//

//import Foundation
//import Firebase
//import UIKit
//import FirebaseDatabase
//
//
//class FirebaseAPI {
//    private init() {}
//
//    static var ref: FIRDatabaseReference {
//        
//        return FIRDatabase.database().reference()
//    }
//    
//    static func storeNewContact(businessName: String, zip: String) {
//        
//        let contactRef = ref.child("Contact")
//        
//        //Create a dictionary containing the info to be stored in the database
//        let serializedData = [
//            "business":businessName,
//            "zip": zip
//        ]
//        
//        //Update the child values at the location
//        contactRef.updateChildValues(serializedData)
//        
//        print("check fb for new contact")
//    }
//
//}
