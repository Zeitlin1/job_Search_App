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

//        let savedLeadXIB = UINib(nibName: "LeadTableViewCell", bundle: nil)
        
//        tableViewOutlet.register(savedLeadXIB, forCellReuseIdentifier: "savedLeadCell")
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(PropertyDetailViewController.dismissKeyboard))
//        
//        self.view.addGestureRecognizer(tap)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadSavedView),name:NSNotification.Name(rawValue: "reloadSaved"), object: nil)

        self.tableViewOutlet.delegate = self
        
        self.tableViewOutlet.dataSource = self
        
        tableViewOutlet.snp.makeConstraints { (make) in
            make.width.equalTo(self.view).multipliedBy(0.9)
            make.height.equalTo(self.view).multipliedBy(0.9)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(65)
            tableViewOutlet.backgroundColor = UIColor.white
        }
        
        tableViewOutlet.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        tableViewOutlet.separatorColor = UIColor.red
        tableViewOutlet.preservesSuperviewLayoutMargins = false
        tableViewOutlet.separatorInset = UIEdgeInsets.zero
        tableViewOutlet.layoutMargins = UIEdgeInsets.zero

        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        syncSavedLeads()
        print("syncing")
        
        }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.central.leads.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let arrayIndex = indexPath.row
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "savedLeadCell", for: indexPath) as! LeadTableViewCell
        
//        let cellNib = [Bundle.main.loadNibNamed("LeadTableViewCell", owner:self, options: nil)]
        
        
    cell.buffBarLabel.text =  String(central.leads[arrayIndex].numberOfCallsTo)
    
    cell.callDateText.text =  central.leads[arrayIndex].callDate
    
    cell.ownerNameText.text =  central.leads[arrayIndex].ownerName
    
    cell.propertyNameText.text =  central.leads[arrayIndex].buildingAddress

    cell.addressText.text = central.leads[arrayIndex].buildingAddress

    cell.callDateText.text = central.leads[arrayIndex].callDate

    cell.secondaryClassText.text = central.leads[arrayIndex].construction
        
        
        var x: String = ""
        var y: String = ""
        var z: String = ""
        
        
        
        if (cell.buffBarLabel.text?.contains("0"))! {
            
                let foodMoji = "🍕"
        
                let luckyEmoji = "🍀"
            
            x = foodMoji + luckyEmoji
            
        if (cell.buffBarLabel.text?.contains("1"))! {
        
                let callEmoji = "☎️"
            
                let lightningEmoji = "⚡️"
        
                let coldEmoji = "❄️"
            
                let BombEmoji = "☢"
            
            y = callEmoji + lightningEmoji + coldEmoji + BombEmoji
            
            }
            
            let fireEmoji = "🔥"
            
            z = fireEmoji
        
            print(x + y + z)
            
            cell.buffBarLabel.text = x + y + z
        
            
                       /* 🍕🔥🍀☎️⚡️❄️☢ */
            
        }

        
//        setCell(cell: cell, index: arrayIndex)
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "leadDetailSegue" {
            if let dest = segue.destination as? LeadDetailViewController,
                let indexPath = self.tableViewOutlet.indexPathForSelectedRow {
                dest.lead = self.central.leads[(indexPath as NSIndexPath).row]
                
            }
        }
    }
    
    func setCell(cell: LeadTableViewCell, index: Int) {
    
//        let selectedArray = self.leads
    
//        cell.leadNameLabel.snp.makeConstraints { (make) in
//            make.centerX.equalTo(cell)
//            make.top.equalTo(cell)
//            make.height.equalTo(cell).multipliedBy(0.5)
//            make.width.equalTo(cell)
//
//            cell.leadNameLabel.textColor = UIColor.blue
//        }
//        
//        cell.lastCalledText.snp.makeConstraints { (make) in
//            make.right.equalTo(cell)
//            make.bottom.equalTo(cell)
//            make.height.equalTo(cell).multipliedBy(0.5)
//            make.width.equalTo(cell).dividedBy(2)
//            cell.lastCalledText.textColor = UIColor.blue
//            let callDate = selectedArray[index].callDate
//
//            
//        }
//        cell.lastCalledLabel.snp.makeConstraints { (make) in
//            make.left.equalTo(cell)
//            make.bottom.equalTo(cell)
//            make.height.equalTo(cell).multipliedBy(0.5)
//            make.width.equalTo(cell).dividedBy(2)
//            cell.lastCalledLabel.textColor = UIColor.blue
//            
//        }
    
    
        
    }
    

    func syncSavedLeads() {
        
        central.reloadCentralArray { 
             print("say hello to my little friend")
        }
        // reload the property array then add all saved leads to it.
    }
    
    
    func reloadSavedView() {
        tableViewOutlet.reloadData()
    }

}
