//
//  SavedLeadsViewController.swift
//  job_Search_App
//
//  Created by Anthony on 1/3/17.
//  Copyright © 2017 Anthony. All rights reserved.
//

import UIKit
import CoreData
import Foundation
import SnapKit
import Firebase

class SavedLeadsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let central = CentralDataStore.shared
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        syncSavedLeads()

        let titleText = "Top Prospects"
        
        let nav = self.navigationController?.navigationBar

        setupNavBar(bar: nav!, text: titleText)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadSavedView),name:NSNotification.Name(rawValue: "reloadSaved"), object: nil)

        self.tableViewOutlet.delegate = self
        
        self.tableViewOutlet.dataSource = self
        
        createGradientLayer(on: self.view)
        
        tableViewOutlet.snp.makeConstraints { (make) in
            make.width.equalTo(self.view).multipliedBy(0.9)
            make.height.equalTo(self.view).multipliedBy(0.9)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(65)
            tableViewOutlet.backgroundColor = UIColor.clear
        }
        
        tableViewOutlet.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        tableViewOutlet.separatorColor = UIColor.red
        tableViewOutlet.preservesSuperviewLayoutMargins = false
        tableViewOutlet.separatorInset = UIEdgeInsets.zero
        tableViewOutlet.layoutMargins = UIEdgeInsets.zero

        
        
    }
    
    override func viewWillAppear(_ animated: Bool) { }
    
    override func viewWillDisappear(_ animated: Bool) { }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.central.leads.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        TipInCellAnimator.animate(cell: cell) { }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let arrayIndex = indexPath.row
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedLeadCell", for: indexPath) as! SavedLeadTableViewCell

    cell.backgroundColor = UIColor.clear
  
    cell.HeadlineTextDisplay.text =  central.leads[arrayIndex].buildingAddress
        
    cell.buffBarIconDisplay.text = "🔥"
        
    cell.lastCalledText.text = central.leads[arrayIndex].callDate
        
        if central.leads[arrayIndex].callDate != "Ready"  {
          
            cell.lastCalledText.textColor = UIColor.white
        
        } else {
        
            cell.lastCalledText.textColor = UIColor.green
        }
        
                       /* 🍕🔥🍀☎️⚡️❄️☢ */
            
//        setCell(cell: cell, index: arrayIndex)
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "leadDetailSegue" {
    
            if let dest = segue.destination as? SavedLeadDetailViewController,
                
                let indexPath = self.tableViewOutlet.indexPathForSelectedRow {
           
                self.central.currentProperty = self.central.leads[(indexPath as NSIndexPath).row]
              
                dest.lead = central.currentProperty
                
            }
        }
    }
    

    func syncSavedLeads() {
        
        central.loadCentralArray { }
        
    }
    
    
    func reloadSavedView() {
        
        tableViewOutlet.reloadData()
        
    }

}
