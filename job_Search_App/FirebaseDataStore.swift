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
    
    func saveToFirebase(business: Business) {
        print(1)
        
        if business.name.contains(".") || business.name.contains("#") || business.name.contains("$") || business.name.contains("[") || business.name.contains("]") { return }
        
        let contactsRef = self.ref.child(business.name)
        print(2)
        // add if statement here to check for duplicates
//        contactsRef.setValue(business.notes, forKey: "notes")
         contactsRef.setValue("test key")
//        contactsRef.setValue(business.classification, forKey: "classification")
//        contactsRef.setValue(business.number, forKey: "contact")
//        contactsRef.setValue(business.numberOfCallsTo, forKey: "timesCalled")
        
        
        }
        
    
    
    
    
    
}
