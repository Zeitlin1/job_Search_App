//
//  Contact.swift
//  job_Search_App
//
//  Created by Anthony on 12/30/16.
//  Copyright © 2016 Anthony. All rights reserved.
////
//
//import Foundation
//import UIKit
//import Firebase
//
//class Contact {
//    let key: String
//    var ownerName: String?
//    var buildingAddress: String?
//    var city: String?
//    var units: String?
//    var contactPhone: String?
//    var yearBuilt: String?
//    var construction: String?
//    var parcelID: String = "0"
//    var callDate: NSDate?
//    var notes: String = ""
//    var numberOfCallsTo: Int = 0
//    var warmLead: Bool = false
//    
//    init(snapshot: FIRDataSnapshot) {
//        key = snapshot.key
//        let snapshotValue = snapshot.value as! [String: AnyObject]
//        
//        self.ownerName = snapshotValue["ownerName"] as! String?
//        self.buildingAddress = snapshotValue["address"] as! String?
//        self.city = snapshotValue["propertyCity"] as! String?
//        self.units = snapshotValue["units"] as! String?
//        self.contactPhone = snapshotValue["contactPhone"] as! String?
//        self.yearBuilt = snapshotValue["yearBuilt"] as! String?
//        self.construction = snapshotValue["construction"] as! String?
//        self.parcelID = key 
//        self.callDate = nil
//    }
//}



