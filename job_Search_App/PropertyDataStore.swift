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

class PropertyDataStore {
    
    var properties = [Property]()
    
    let sharedCoreData = CoreDataStack.shared
    
    let fireBaseDB = FirebaseDataStore.sharedInst
    
    static let sharedInstance = PropertyDataStore()
    
    private init(){}
    
    func getBusinessDataFromApi(_ completion: @escaping () -> Void) {

        DataAPIClient.getBusinessData { (arrayOfDictionaries) in
            
                for property in arrayOfDictionaries {
                
                let newProperty = Property.init(dictionary: property)

                if  DataScrub.sharedInstance.scrubData(newProp: newProperty) == true {
                   
                    self.properties.append(newProperty)

                    FirebaseDataStore.sharedInst.checkForDuplicate(property: newProperty)
                }
            }
            completion()
        }
    }
    
//    func loadFBInfo(newFBProperty: Property) {
//        
//        self.properties.append(newFBProperty)
//    }
    
    func setLeadCold(lead: Lead) {
        
        for i in properties {
            if i.parcelID == lead.parcelID {
                i.warmLead = false
            }
        }
       fireBaseDB.updateFirebaseLead(lead: lead)
    }
    
   
    func updateCDProperty(property: Property) {
        
        if property.warmLead == true {
            sharedCoreData.updateCoreData(target: property)
        }
    }
    
    func updateFB(property: Property) {
        FirebaseDataStore.sharedInst.updateExisting(property: property)
    }
    
    func updateCDLead(lead: Lead) {
        
        if lead.warmLead == true {
            sharedCoreData.updateCoreDataLead(target: lead)
        }
    }
    
    func updateFBLead(theLead: Lead) {
        FirebaseDataStore.sharedInst.updateFirebaseLead(lead: theLead)
    }
    
    func updatePropertiesArray(lead: Lead) {
    
        for i in properties {
            if i.parcelID == lead.parcelID {
                
                i.notes = lead.notes!
                
                i.callDate = lead.callDate!
                
                i.numberOfCallsTo = Int(lead.numberOfCalls)
           
            }
        }
    }
    
    
}
