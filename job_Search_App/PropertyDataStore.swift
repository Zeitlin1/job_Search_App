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
    
    
    
    
    func setLeadCold(lead: Lead) {
        
        for i in properties {
            if i.parcelID == lead.parcelID {
                i.warmLead = false
            }
        }
        FirebaseDataStore.sharedInst.toggleLeadCold(lead: lead)
    }
    
   
    func updateFBandCDProperty(property: Property) {
        
        if property.warmLead == true {
            sharedCoreData.updateCoreData(target: property)
        }
        FirebaseDataStore.sharedInst.updateExisting(property: property)
    }

    
    func updateFBandCDLead(lead: Lead) {
        
        if lead.warmLead == true {
            sharedCoreData.updateCoreDataLead(target: lead)
        }
        
        for i in properties {
            if i.parcelID == lead.parcelID {
                
                i.notes = lead.notes!
                i.callDate = lead.callDate
                i.numberOfCallsTo = Int(lead.numberOfCalls)
           
            }
        }
        
        FirebaseDataStore.sharedInst.updateExistingLead(lead: lead)
    }
    
}
