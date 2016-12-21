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
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "job_Search_App")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    
    func getBusinessDataFromApi(_ completion: @escaping () -> Void) {
        
        nycDataAPIClient.getBusinessData { (arrayOfDictionaries) in
            
            for business in arrayOfDictionaries {
                print("NEW BUSINESS StARTED")
                let newBusiness = Business.init(dictionary: business)
                print("NEW BIZ COMPLETED")
                self.businesses.append(newBusiness)
                
            }
            
            completion()
        
        }
        
    }
    
    

    
    
    
}
