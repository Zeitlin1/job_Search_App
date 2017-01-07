//
//  DataScrub.swift
//  job_Search_App
//
//  Created by Anthony on 12/31/16.
//  Copyright © 2016 Anthony. All rights reserved.
//

import Foundation
import UIKit


class DataScrub {
    
    static let shared = DataScrub()

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
    
//    func scrubEmail(newEmail: Email) -> Bool {
//        
//        if !(newEmail.contactPhone?.isEmpty)! && !newProp.parcelID.isEmpty {
//            
//            if newEmail.parcelID.contains(".")
//                || newEmail.parcelID.contains("#")
//                || newEmail.parcelID.contains("$")
//                || newEmail.parcelID.contains("[")
//                || newEmail.parcelID.contains("]")
//            { return false }
//            
//            return true
//            
//        }
//        
//        return false
//        
//    }
}
