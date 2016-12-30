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
    
    override func viewWillAppear(_ animated: Bool) {
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedLeadCell", for: indexPath) as! LeadTableViewCell
        
        let arrayIndex = indexPath.row
        
        let selectedArray = leads
        
        
        cell.leadNameLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(cell)
            make.top.equalTo(cell)
            make.height.equalTo(cell).multipliedBy(0.5)
            make.width.equalTo(cell)
            cell.leadNameLabel.text = selectedArray[arrayIndex].ownerName
            cell.leadNameLabel.textColor = UIColor.blue
        }
        
        cell.lastCalledText.snp.makeConstraints { (make) in
            make.right.equalTo(cell)
            make.bottom.equalTo(cell)
            make.height.equalTo(cell).multipliedBy(0.5)
            make.width.equalTo(cell).dividedBy(2)
            cell.lastCalledText.textColor = UIColor.blue
            
            if let callDate = selectedArray[arrayIndex].callDate {
                
                let dateFormatter = DateFormatter()
                
                dateFormatter.dateStyle = DateFormatter.Style.medium
                
                cell.lastCalledText.text = String(describing: dateFormatter.string(from: callDate as Date))
                
            } else { cell.lastCalledText.text = "Not Called" }
            
        }
        cell.lastCalledLabel.snp.makeConstraints { (make) in
            make.left.equalTo(cell)
            make.bottom.equalTo(cell)
            make.height.equalTo(cell).multipliedBy(0.5)
            make.width.equalTo(cell).dividedBy(2)
            cell.lastCalledLabel.textColor = UIColor.blue
        
        }
        
        return cell
        
    }

    
    func fetchData(){
        
        let managedContext = store.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Lead> = Lead.fetchRequest()
        
        do{
            
            self.leads = try managedContext.fetch(fetchRequest)
            
            self.tableView.reloadData()
            
        }catch{
            
        }
        
        
        
    }


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "leadDetailSegue" {
            if let dest = segue.destination as? LeadDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                dest.lead = leads[(indexPath as NSIndexPath).row]
                
            }
        }
    }

}
