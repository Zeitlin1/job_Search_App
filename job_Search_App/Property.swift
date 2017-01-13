//
//  Property.swift
//  job_Search_App
//
//  Created by Anthony on 12/20/16.
//  Copyright © 2016 Anthony. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Property {
    var ownerName: String?
    var buildingAddress: String?
    var city: String?
    var units: String?
    var contactPhone: String?
    var yearBuilt: String?
    var construction: String?
    var parcelID: String = "0"
    var callDate: String = "Ready"
    var notes: String = ""
    var numberOfCallsTo: Int = 0
    var warmLead: Bool = false
    var squareFootageOfLot: Double?
    var squareFootageOfBuilding: Double?
    var emails = [String]()
    
    /* NEW Variable for Chart */
    
    var callLog = [Call]()
    
    
    init(dictionary: [String: Any]) {
      
        self.ownerName = dictionary["FIELD1"] as! String?
 
        self.buildingAddress = dictionary["FIELD2"] as! String?
 
        self.city = dictionary["FIELD3"] as! String?
  
        self.units = dictionary["FIELD4"] as! String?
 
        self.contactPhone = dictionary["FIELD5"] as! String?
 
        self.yearBuilt = dictionary["FIELD6"] as! String?
       
        self.construction = dictionary["FIELD7"] as! String?
        
        self.parcelID = dictionary["FIELD8"] as! String
    
       
    }
    
    
    /// uncomment emails stuff below

    init(snapshot: FIRDataSnapshot) {
        
        let snapshotValue = snapshot.value as! [String: AnyObject]
        
        self.parcelID = snapshot.key
        
        self.ownerName = snapshotValue["ownerName"] as! String?
        
        self.buildingAddress = snapshotValue["address"] as! String?
        
        self.city = snapshotValue["propertyCity"] as! String?
        
        self.units = snapshotValue["units"] as! String?
        
        self.contactPhone = snapshotValue["contactPhone"] as! String?
        
        self.yearBuilt = snapshotValue["yearBuilt"] as! String?
        
        self.construction = snapshotValue["construction"] as! String?
        
        self.notes = (snapshotValue["notes"] as! String!)!
        
        self.numberOfCallsTo = snapshotValue["numberOfCalls"] as! Int
        
        self.warmLead = snapshotValue["warmLead"] as! Bool
    
        self.emails = snapshotValue["emails"] as! [String]
   
    }
}
