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
    
    let sharedCoreData = CoreDataStack.shared
    
    let sharedFireBase = FirebaseDataStore.shared
    
    var properties = [Property]()
    
    var leads = [Lead]()
    
    private init(){ print("Init coredata")   }
    
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
    
    
    func updateFireBase(property: Property) {
        sharedFireBase.saveToFirebase(property: property)
        populateCentralArray()
    }
    
    
    func updateCDLead(lead: Lead) {
        sharedCoreData.updateCoreDataLead(target: lead)
    }
    
    func updateFBLead(theLead: Lead) {
        sharedFireBase.updateFirebaseLead(lead: theLead)
    }
    
    

    func populateCentralArray() {
        sharedFireBase.populateArrayFromFirebase { prop in
            self.properties = prop
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }
    }
    
    func fetchLeadsFromCoreData(){
        
        leads = []
        
        let managedContext = sharedCoreData.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Lead> = Lead.fetchRequest()
        
        do{
            
            leads = try managedContext.fetch(fetchRequest)
            
            
        }catch{
            
        }
        
    }
}
