//
//  nycDataAPIClient.swift
//  job_Search_App
//
//  Created by Anthony on 12/20/16.
//  Copyright © 2016 Anthony. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class nycDataAPIClient {
    
    class func getBusinessData(with completion: @escaping ([[String: Any]]) -> Void){
        
        let url = URL(string: nycURL)
        
        if let unwrappedURL = url {
           
            let session = URLSession.shared
            
            let task = session.dataTask(with: unwrappedURL) { (data, response, error) in
                
                if let unwrappedData = data {
                    
                    do {
                        
                        let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as! [[String: Any]]
                        
                        completion(responseJSON)
            
                       // print(responseJSON)
                    
                    } catch {
                    
                    }
                
                }
            
            }
            
            task.resume()
        
        }
    
    }
    
}


    
