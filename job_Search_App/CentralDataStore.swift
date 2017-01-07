//
//  PropertyDataStore.swift
//  job_Search_App
//
//  Created by Anthony on 12/20/16.
//  Copyright © 2016 Anthony. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Firebase
import FirebaseDatabase
import FirebaseStorage

class CentralDataStore {
    
    static let shared = CentralDataStore()
    
    let sharedFireBase = FirebaseDataStore.shared
    
    var properties = [Property]()
    
    var leads = [Property]()
    
    // used by dashboard to put FB info into [Property] array
    func getBusinessDataFromApi(_ completion: @escaping () -> Void) {

        DataAPIClient.getBusinessData { (arrayOfDictionaries) in
            
                for property in arrayOfDictionaries {
                
                let newProperty = Property.init(dictionary: property)

                if  DataScrub.shared.scrubData(newProp: newProperty) == true {

                    self.sharedFireBase.checkForDuplicate(property: newProperty)
                }
            }
            
            completion()
        }
    }
    
    func getEmailDataFromApi(urlString: String, _ completion: @escaping () -> Void) {
        
        DataAPIClient.getEmailData(string: urlString, with: { (arrayOfDictionaries) in
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopIndicator"), object: nil)
            
            for email in arrayOfDictionaries {
                
                print("THIS IS EMAIL KEY \(email.0) KKKKEEEYYY")
                print("THIS IS EMAIL VALUE \(email.1)   VVVVVVALUE")
                
                
///                let newProperty = Property.init(dictionary: email)
                
///         if  DataScrub.shared.scrubData(newProp: newProperty) == true {
    
///                   self.sharedFireBase.checkForDuplicate(property: newProperty)
///                }
            }
            completion()
            })
            
        
    }
    
    
    func updateFirebaseProperty(property: Property) { // both updates FB and reloads central array
        let ref = FIRDatabase.database().reference(withPath: "contacts")
        
        let propertyRef = ref.child(property.parcelID)
        
        let serializedData = [
            "notes": property.notes,
            "numberOfCalls": property.numberOfCallsTo,
            "warmLead": property.warmLead,
            "callDate": property.callDate
            ] as [String : Any]
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopIndicator"), object: nil)
        
        propertyRef.updateChildValues(serializedData)
        
        
        reloadCentralArray {
            print("I'm relooooding")
        }
        
    }
    
    func reloadCentralArray(completion: () -> Void) {
       
        sharedFireBase.populateArrayFromFirebase { prop in
           
            self.properties = prop // this sets the proeprties array equal to the current firebase state.
           
            self.leads = []
            
            for d in self.properties {
                
                if d.warmLead == true {
                   
                    self.leads.append(d)
                }
                
            }
         
NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopIndicator"), object: nil)
 NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadSaved"), object: nil)
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            
            
        }
    }

}

protocol DataFile {
//    static var shared: CentralDataStore { get }
//    static var central: FirebaseDataStore { get }
}
