//
//  Property.swift
//  job_Search_App
//
//  Created by Anthony on 12/20/16.
//  Copyright © 2016 Anthony. All rights reserved.
//

import Foundation
import UIKit

class Property {
    var ownerName: String?
    var buildingAddress: String?
    var city: String?
    var units: String?
    var contactPhone: String?
    var yearBuilt: String?
    var construction: String?
    var parcelID: String = "0"
    var callDate: NSDate?
    var notes: String = ""
    var numberOfCallsTo: Int = 0
    var warmLead: Bool = false
    
    init(dictionary: [String: Any]) {
        self.ownerName = dictionary["FIELD1"] as! String?
        self.buildingAddress = dictionary["FIELD2"] as! String?
        self.city = dictionary["FIELD3"] as! String?
        self.units = dictionary["FIELD4"] as! String?
        self.contactPhone = dictionary["FIELD5"] as! String?
        self.yearBuilt = dictionary["FIELD6"] as! String?
        self.construction = dictionary["FIELD7"] as! String?
        self.parcelID = dictionary["FIELD8"] as! String
        self.callDate = nil
    }
}
