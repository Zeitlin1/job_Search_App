//
//  DataScrub.swift
//  job_Search_App
//
//  Created by Anthony on 12/31/16.
//  Copyright © 2016 Anthony. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class DataScrub {

    let sharedCoreData = CoreDataStack.shared
    
    static let sharedInstance = DataScrub()

    private init(){}

    func scrubData(newProp: Property) -> Bool {
        
        if !(newProp.contactPhone?.isEmpty)! && !newProp.parcelID.isEmpty {
            
            if newProp.parcelID.contains(".")
                || newProp.parcelID.contains("#")
                || newProp.parcelID.contains("$")
                || newProp.parcelID.contains("[")
                || newProp.parcelID.contains("]")
            { return false }
            
            return true
            
        }
        
        return false
        
    }
}
