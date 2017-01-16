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
    
    var currentProperty: Property?
    
    var leads = [Property]()
    
    func getBusinessDataFromApi(_ completion: @escaping () -> Void) {

        DataAPIClient.getBusinessData { (arrayOfDictionaries) in
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopIndicator"), object: nil)
            
                for property in arrayOfDictionaries {
                  
                    let newProperty = Property.init(dictionary: property)
                    
                    if  DataScrub.shared.scrubData(newProp: newProperty) == true {
                       
                        self.sharedFireBase.checkForDuplicate(property: newProperty)
                        
                    }
                    
            completion()
        }
    }
    }


    
    func findEmailData(domain: String, completion: @escaping ([String]) -> Void) {
        
        DataAPIClient.getEmailData(string: domain, with: { (emailArray) in
        
            /// let meta = emailArray["meta"] as! [String: Any]
            
            var completionEmailArray = [String]()
         
            let data = emailArray["data"] as! [String: Any]
  
            let emailData = data["emails"] as! [[String: Any]]

            for email in emailData {
              
                let actualEmail = email["value"] as! String
             
                completionEmailArray.append(actualEmail)
            }
            completion(completionEmailArray)
        })
    }
    
    
    func updateFirebaseProperty(property: Property) { // both updates FB and reloads central array
        let ref = FIRDatabase.database().reference(withPath: "contacts")
        
        let propertyRef = ref.child(property.parcelID)
        
        let serializedData = [
            "notes": property.notes,
            "numberOfCalls": property.numberOfCallsTo,
            "warmLead": property.warmLead,
            "callDate": property.callDate,
            "emails": property.emails
            
            ] as [String : Any]

        propertyRef.updateChildValues(serializedData) { (_, _) in
            
            self.reloadCentralArray {
                
            }
            
        }
        
        
        
    }
    
    func loadCentralArray(completion: () -> Void) {
   
            sharedFireBase.populateArrayFromFirebase { prop in
        
                        self.properties = prop
                       
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
    
    func reloadCentralArray(completion: () -> Void) {
        
        sharedFireBase.populateArrayFromFirebase { prop in
            
            self.properties = prop // this sets the properties array equal to the current firebase state.
            
            self.leads = []
            
            for d in self.properties {
                
                if d.warmLead == true {
                    
                    self.leads.append(d)
                    print("lead reappended")
                }
                
            }
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadSaved"), object: nil)
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopIndicator"), object: nil)
        }
    }

    
    
    
    

}

