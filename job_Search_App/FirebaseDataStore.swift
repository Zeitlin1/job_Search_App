//
//  FirebaseDataStore.swift
//  job_Search_App
//
//  Created by Anthony on 12/29/16.
//  Copyright © 2016 Anthony. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class FirebaseDataStore {
    
    static let shared = FirebaseDataStore()
    
    private init(){}
    
    func saveToFirebase(property: Property) {
        
        let ref = FIRDatabase.database().reference(withPath: "contacts")
        
        let propertyRef = ref.child(property.parcelID)
        
        let serializedData = [
            "construction": property.construction,
            "propertyCity": property.city,
            "contactPhone": property.contactPhone,
            "ownerName": property.ownerName,
            "units": property.units,
            "yearBuilt": property.yearBuilt,
            "address": property.buildingAddress,
            "notes": property.notes,
            "numberOfCalls": property.numberOfCallsTo,
            "warmLead": property.warmLead,
            "callDate": property.callDate
        ] as [String : Any]
        
        propertyRef.updateChildValues(serializedData)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        /// remove that notification in a sec
        }
    
    
    
    
//    func updateFirebaseLead(lead: Lead) {
//        let ref = FIRDatabase.database().reference(withPath: "contacts")
//        
//        let propertyRef = ref.child(lead.parcelID!)
//        
//        let serializedData = [
//            "notes": lead.notes,
//            "numberOfCalls": lead.numberOfCalls,
//            "warmLead": lead.warmLead,
//            "callDate": lead.callDate
//            ] as [String : Any]
//
//        propertyRef.updateChildValues(serializedData)
//       
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
//        
//    }

    
    func checkForDuplicate(property: Property) {
        
        let ref = FIRDatabase.database().reference(withPath: "contacts")
    
        ref.observeSingleEvent(of: .value, with: { snapshot in
            
            if !snapshot.hasChild(property.parcelID) {
                
                self.saveToFirebase(property: property)
                print("Added single lead from FBStorage to FBDB")
            } else if snapshot.hasChild(property.parcelID) {
            print("Duplicate Value")
                
/***************** used to delete from FireB programatically ***************/
//                ref.removeValue(); print(111111)
//                let propertyRef = ref.child(property.parcelID); propertyRef.removeValue(); print("Deleted from FB")
                
/***************** used to delete from FireB programatically ***************/
            
            }
        })
    }
    
    
    func populateArrayFromFirebase(completion: @escaping ([Property]) -> Void){
        
        var populatedArray: [Property] = []
        
        let ref = FIRDatabase.database().reference(withPath: "contacts")
        
        ref.observeSingleEvent(of: .value, with: { snapshot in
            
            if snapshot.hasChildren() {
                
                for child in snapshot.children {
                    
                let fbProperty = Property.init(snapshot: child as! FIRDataSnapshot)
                   
                populatedArray.append(fbProperty)
                    
                
                }
                completion(populatedArray)
            }
            
            
        })
        
    }
    

    
    
    
    

}
