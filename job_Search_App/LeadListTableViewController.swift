//
//  LeadListTableViewController.swift
//  job_Search_App
//
//  Created by Anthony on 12/23/16.
//  Copyright © 2016 Anthony. All rights reserved.
//

import UIKit
import Foundation
import CoreData
import SnapKit

class LeadListTableViewController: UITableViewController {

    
    var leads = [Lead]()
    
    let store = CoreDataStack.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()

    }

   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leads.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("before lead view stuff")
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedLeadCell", for: indexPath) as! LeadTableViewCell
        
        let arrayIndex = indexPath.row
        
        let selectedArray = leads
        
        
        cell.leadNameLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(cell)
            make.top.equalTo(cell)
            make.height.equalTo(cell).multipliedBy(0.5)
            make.width.equalTo(cell)
            cell.leadNameLabel.text = selectedArray[arrayIndex].name
            cell.leadNameLabel.textColor = UIColor.blue
        }
        
        cell.lastCalledLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(cell)
            make.bottom.equalTo(cell)
            make.height.equalTo(cell).multipliedBy(0.5)
            make.width.equalTo(cell)
            cell.lastCalledLabel.textColor = UIColor.blue
            
            if let callDate = selectedArray[arrayIndex].lastCallDate {
                
                let dateFormatter = DateFormatter()
                
                dateFormatter.dateStyle = DateFormatter.Style.medium
                
                cell.lastCalledLabel.text = String(describing: dateFormatter.string(from: callDate as Date))
                
            } else { cell.lastCalledLabel.text = "Not Called" }
            
        }
        
        
        
        
        return cell
        
    }

    
    func fetchData(){
        
        let managedContext = store.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Lead> = Lead.fetchRequest()
        
        do{
            
            self.leads = try managedContext.fetch(fetchRequest)
            
            print(leads.count)
            
            self.tableView.reloadData()
            
        }catch{
            
        }
        
        
        
    }

}
