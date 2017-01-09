//
//  DataAPIClient.swift
//  job_Search_App
//
//  Created by Anthony on 12/20/16.
//  Copyright © 2016 Anthony. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class DataAPIClient {
    
//    func urlSwitch(string: String) -> URL {
//        
//          return URL(string: "bad url")!
//        }
    
    
    class func getBusinessData(with completion: @escaping ([[String: Any]]) -> Void){
        
        // change this to pull file from Dropbox instead of random API
       // let url = URL(string: nycURL)
        
        let urlSwitch = URL(string: firebaseStorageTestJson)
        
        if let unwrappedURL = urlSwitch {
           
            let session = URLSession.shared
            
            let task = session.dataTask(with: unwrappedURL) { (data, response, error) in
                
                if let unwrappedData = data {
                    
                    do {
                        
                        let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as! [[String: Any]]
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopIndicator"), object: nil)
                        
                        completion(responseJSON)
                    
                    } catch {
                        
                    print(error.localizedDescription)
                    
                    }
                }
            }
            task.resume()
        }
    }
    
     class func getEmailData(string: String, with completion: @escaping ([String: Any]) -> Void) {
       
        let url = URL(string: hunterAPIkeyDOMAIN_Search)

        if let unwrappedURL = url {
        
            let session = URLSession.shared
            
            let task = session.dataTask(with: unwrappedURL) { (data, response, error) in
                
                if let unwrappedData = data {
                    
                    do {
                        
                        let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as! [String: Any]
                        
                        //print(responseJSON)
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopIndicator"), object: nil)
                        
                        completion(responseJSON)
                        
                    } catch {
                        
                        print(error.localizedDescription)
                        
                    }
                }
            }
            task.resume()
        }
        
        }
    
    
    


}
