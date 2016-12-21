//
//  ViewController.swift
//  job_Search_App
//
//  Created by Anthony on 12/20/16.
//  Copyright © 2016 Anthony. All rights reserved.
//

import UIKit
import Foundation
import SnapKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let store = BusinessDataStore.sharedInstance
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableViewOutlet.delegate = self
        
        self.tableViewOutlet.dataSource = self
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        print("section fired")
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return store.businesses.count
        
    }
  
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("before table view stuff")
        let cell = tableView.dequeueReusableCell(withIdentifier: "businessCell", for: indexPath) as! TableViewCell
        
        let arrayIndex = indexPath.row
        
        let selectedArray = store.businesses
        print(1)
        cell.businessNameLabel.text = selectedArray[arrayIndex].name
        print(2)
        cell.CityLabel.text = selectedArray[arrayIndex].classification
       print(3)
        print("tableview 2")
        
        return cell
        
    }


   
    @IBAction func findBusinessButton(_ sender: Any) {
        
        store.getBusinessDataFromApi {
           
            DispatchQueue.main.async {
                self.tableViewOutlet.reloadData()
            
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "businessDetailSegue" {
            if let dest = segue.destination as? BusinessDetailViewController, let indexPath = tableViewOutlet.indexPathForSelectedRow {
                dest.business = store.businesses[(indexPath as NSIndexPath).row]
                
                
                
            }
        }
    }
    
    
    
}

