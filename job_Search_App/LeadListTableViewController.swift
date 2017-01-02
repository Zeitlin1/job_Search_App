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

    let dataStore = PropertyDataStore.sharedInstance
    
    let store = CoreDataStack.shared
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
  
        self.tableView.separatorColor = UIColor.red
  
        self.tableView.preservesSuperviewLayoutMargins = false
       
        self.tableView.separatorInset = UIEdgeInsets.zero
     
        self.tableView.layoutMargins = UIEdgeInsets.zero
       
    }

    override func viewWillAppear(_ animated: Bool) {
        
        fetchData()
    
        self.tableView.reloadData()
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leads.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "savedLeadCell", for: indexPath) as! LeadTableViewCell
       
        let arrayIndex = indexPath.row
       
        setCell(cell: cell, index: arrayIndex)
       
        return cell
        
    }
  
    func fetchData(){
        
        leads = []
        
        let managedContext = store.persistentContainer.viewContext
       
        let fetchRequest: NSFetchRequest<Lead> = Lead.fetchRequest()
        
        do{
            
            self.leads = try managedContext.fetch(fetchRequest)
            
     
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
    
    func setCell(cell: LeadTableViewCell, index: Int) {

        let selectedArray = leads
       
        cell.leadNameLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(cell)
            make.top.equalTo(cell)
            make.height.equalTo(cell).multipliedBy(0.5)
            make.width.equalTo(cell)
            cell.leadNameLabel.text = selectedArray[index].ownerName
            cell.leadNameLabel.textColor = UIColor.blue
        }
        
        cell.lastCalledText.snp.makeConstraints { (make) in
            make.right.equalTo(cell)
            make.bottom.equalTo(cell)
            make.height.equalTo(cell).multipliedBy(0.5)
            make.width.equalTo(cell).dividedBy(2)
            cell.lastCalledText.textColor = UIColor.blue
            let callDate = selectedArray[index].callDate
            cell.lastCalledText.text = callDate

        }
        cell.lastCalledLabel.snp.makeConstraints { (make) in
            make.left.equalTo(cell)
            make.bottom.equalTo(cell)
            make.height.equalTo(cell).multipliedBy(0.5)
            make.width.equalTo(cell).dividedBy(2)
            cell.lastCalledLabel.textColor = UIColor.blue
           
        }
    }
    
}
