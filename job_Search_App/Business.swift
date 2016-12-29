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
    
    var id: String?
    
    var notes: String = ""
    
    var numberOfCallsTo: Int = 0
    
    var warmLead: Bool = false
    
    init(dictionary: [String: Any]) {
    
        self.name = dictionary["FIELD2"] as! String
        self.addressZip = dictionary["FIELD1"] as? String
        self.classification = dictionary["FIELD7"] as? String
        self.number = dictionary["FIELD5"] as? String
        self.id = dictionary["FIELD8"] as? String
        self.callDate = nil
        
    }
    
}
