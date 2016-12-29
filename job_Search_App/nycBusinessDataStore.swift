//
//  nycBusinessDataStore.swift
//  job_Search_App
//
//  Created by Anthony on 12/20/16.
//  Copyright © 2016 Anthony. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class BusinessDataStore {
    
    var businesses = [Business]()
    
    static let sharedInstance = BusinessDataStore()
    
    private init(){}
    
    func getBusinessDataFromApi(_ completion: @escaping () -> Void) {
        
        nycDataAPIClient.getBusinessData { (arrayOfDictionaries) in
            
            for business in arrayOfDictionaries {
                let newBusiness = Business.init(dictionary: business)
                self.businesses.append(newBusiness)
                FirebaseDataStore.sharedInst.saveToFirebase(business: newBusiness)
            }
            completion()
        }
    }
    
    func setLeadCold(name: String) {
        for business in businesses {
            if business.name == name {
                business.warmLead = false
            }
        }
    }
    
    func update(lead: Lead) {
        for business in businesses {
            if business.name == lead.name {
                business.notes = lead.notes ?? "SET TO EMPTY FOR PRODUCTION"
                business.callDate = lead.lastCallDate
                business.numberOfCallsTo = Int(lead.timesCalled)
                business.warmLead = lead.warmLead
                print("PREVIOUS MATCH FOUND")
            }
        }
    }

    
    
    
}
