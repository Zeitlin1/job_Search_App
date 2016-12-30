//
//  FirebaseDataStore.swift
//  job_Search_App
//
//  Created by Anthony on 12/29/16.
//  Copyright © 2016 Anthony. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class FirebaseDataStore {
    
    static let sharedInst = FirebaseDataStore()
    
    private init(){}
    
    let ref = FIRDatabase.database().reference(withPath: "contacts")
    
    
    func saveToFirebase(property: Property) {
        
        let propertyRef = self.ref.child(property.parcelID)

        let serializedData = [
            "construction": property.construction,
            "propertyCity": property.city,
            "contactPhone": property.contactPhone,
            "ownerName": property.ownerName,
            "units": property.units,
            "yearBuilt": property.yearBuilt,
            "address": property.buildingAddress
        ] as [String : Any]
        
        //Update the child values at the location
        propertyRef.updateChildValues(serializedData)
        
        }



    func updateChildVal() -> Bool {
        // update child value with changes here
        return true
    }
    
    func checkForDuplicate(property: Property) {
        
        ref.observeSingleEvent(of: .value, with: { snapshot in
            
            if !snapshot.hasChild(property.parcelID) {
                print(property.parcelID)
                self.saveToFirebase(property: property)
                print("Saved, NO Duplicate")
            } else if snapshot.hasChild(property.parcelID) {
                print("DUPLICATE")
            }
        })
    }
    
}
