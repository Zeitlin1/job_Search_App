//
//  nycBusiness.swift
//  job_Search_App
//
//  Created by Anthony on 12/20/16.
//  Copyright © 2016 Anthony. All rights reserved.
//

import Foundation
import UIKit

class Business {
    
    var name: String
    
    var addressZip: String?
    
    var number: String?
    
    var classification: String?
    
    var callDate: NSDate?
    
    var notes: String = "No notes yet"
    
    var numberOfCallsTo: Int = 0
    
    var warmLead: Bool = false
    
    init(dictionary: [String: Any]) {
    
        self.name = dictionary["business_name"] as! String
        self.addressZip = dictionary["address_zip"] as? String
        self.classification = dictionary["license_category"] as? String
        self.number = dictionary["contact_phone"] as? String
        self.callDate = nil
        
    }
    
}
