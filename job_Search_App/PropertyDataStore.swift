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

class PropertyDataStore {
    
    var properties = [Property]()
    
    static let sharedInstance = PropertyDataStore()
    
    private init(){}
    
    func getBusinessDataFromApi(_ completion: @escaping () -> Void) {
        
        // GET ALL DATA FROM STORAGE AS JSON
        nycDataAPIClient.getBusinessData { (arrayOfDictionaries) in
            
            // GO THROUGH ALL JSON DATA, AND FILTER OUT THE JUNK
            for property in arrayOfDictionaries {
                
                let newProperty = Property.init(dictionary: property)
                
                // IF THERE IS PHONE DATA, PARCELID, and NOT ALREADY IN FB, ADD IT TO OUR ARRAY and FB
                if self.scrubData(newProp: newProperty) == true {
                   
                    self.properties.append(newProperty)
                   
                    FirebaseDataStore.sharedInst.checkForDuplicate(property: newProperty)
//                    FirebaseDataStore.sharedInst.saveToFirebase(property: newProperty)
                    
                }
               
            }
            completion()
        }
    }
    
    func setLeadCold(name: String) {
        for property in properties {
            if property.buildingAddress == name {
                property.warmLead = false
            }
        }
    }
    
    func update(lead: Lead) {
        for property in properties {
            if property.buildingAddress == lead.buildingAddress {
                property.notes = lead.notes ?? "SET TO EMPTY FOR PRODUCTION"
                property.callDate = lead.callDate
                property.numberOfCallsTo = Int(lead.numberOfCalls)
                property.warmLead = lead.warmLead
                print("PREVIOUS MATCH FOUND")
                
                // update in coredata
            }
        }
    }


    
    
    func scrubData(newProp: Property) -> Bool {
      
        if !(newProp.contactPhone?.isEmpty)! && !newProp.parcelID.isEmpty {
        
            if newProp.parcelID.contains(".")
                || newProp.parcelID.contains("#")
                || newProp.parcelID.contains("$")
                || newProp.parcelID.contains("[")
                || newProp.parcelID.contains("]")
            { return false }
          
//            if checkForDuplicate(property: newProp) == true {
//             return false
//            }
       
        return true
        
        }
        
        return false
    
    }
    
    
}
