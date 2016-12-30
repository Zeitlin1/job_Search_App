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
    
    let sharedCoreData = CoreDataStack.shared
    
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
                    
                  //  print("count is \(self.properties.count)")

                }
               
            }
            completion()
        }
    }
    
    func setLeadCold(lead: Lead) {
            
        FirebaseDataStore.sharedInst.toggleLeadStatus(lead: lead)

    }
    
    func updateProperty(property: Property) {
        
        // update in FireBase
        
        FirebaseDataStore.sharedInst.updateExisting(property: property)
        
        if property.warmLead == true {
           sharedCoreData.retrieveCoreDataNotes()
        }

    }
    
    func updateLead(lead: Lead) {
        CoreDataStack.shared.saveContext()
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
