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
import Firebase
import FirebaseDatabase


class LeadListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var central = CentralDataStore.shared
   
    @IBOutlet weak var tableViewOutlet: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(LeadListViewController.reloadView),name:NSNotification.Name(rawValue: "load"), object: nil)
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(PropertyDetailViewController.dismissKeyboard))
//        
//        self.view.addGestureRecognizer(tap)

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
        tableViewOutlet.separatorColor = UIColor.blue
        tableViewOutlet.preservesSuperviewLayoutMargins = false
        tableViewOutlet.separatorInset = UIEdgeInsets.zero
        tableViewOutlet.layoutMargins = UIEdgeInsets.zero

    }

    override func viewWillAppear(_ animated: Bool) {
        
        central.reloadCentralArray { 
            self.tableViewOutlet.reloadData()
        }
         // updates table view to show current state of central's [Property] array
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return central.properties.count
        
    
    }
   
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "propertyCell", for: indexPath) as! TableViewCell
        
//        let arrayIndex = indexPath.row
        
        

       // setCell(cell: cell, index: arrayIndex)

        return cell
        
    }

    // passes chosen proerty's info to detail view (orig. from prop array)
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "propertyDetailSegue" {
         
            if let dest = segue.destination as? PropertyDetailViewController, let indexPath = tableViewOutlet.indexPathForSelectedRow {
             
                dest.property = central.properties[(indexPath as NSIndexPath).row]
                
            }
        }
    }
    
//    func setCell(cell: TableViewCell, index: Int) {
//        
//        let selectedArray = central.properties

//        cell. .snp.makeConstraints { (make) in
//            make.width.equalTo(cell)
//            make.centerX.equalTo(cell)
//            make.top.equalTo(cell).offset(5)
//        }
//        
//        cell.addressLabel.snp.makeConstraints { (make) in
//            make.width.equalTo(cell)
//            make.centerX.equalTo(cell)
//            make.top.equalTo(cell.propertyNameText).offset(18)
//        }
//        cell.lastCalledLabel.snp.makeConstraints { (make) in
//            make.width.equalTo(cell).multipliedBy(0.5)
//            make.left.equalTo(cell)
//            make.bottom.equalTo(cell).offset(-5)
//        }
//        cell.lastCalledText.snp.makeConstraints { (make) in
//            make.width.equalTo(cell).multipliedBy(0.5)
//            make.right.equalTo(cell)
//            make.bottom.equalTo(cell).offset(-5)
//        }
//        
//        cell.warmLeadImage.snp.makeConstraints { (make) in
//            make.width.equalTo(cell).multipliedBy(0.1)
//            make.height.equalTo(cell).multipliedBy(0.7)
//            make.centerX.equalTo(cell)
//            make.bottom.equalTo(cell).offset(-2)
        
//        }
//        
//        cell.propertyNameText.textColor = UIColor.black
//        cell.lastCalledText.textColor = UIColor.black
//        cell.lastCalledLabel.textColor = UIColor.black
//        cell.addressLabel.textColor = UIColor.black
    
//        if let bAddress = selectedArray[index].buildingAddress {
//            cell.addressText.text = bAddress
//        }
//        if let owner = selectedArray[index].ownerName {
//            cell.ownerText.text = owner
//        }
//
//        cell.lastCalledText.text = selectedArray[index].callDate
//        
//    
//        
//        if selectedArray[index].warmLead == true {
//            cell.backgroundColor = UIColor.red.withAlphaComponent(0.01)
//            
//            cell.Hot.isHidden = false
//        
//        } else {
//            cell.backgroundColor = UIColor.clear
//            cell.Hot.isHidden = true
//        }
//    }
    
    func reloadView() {
        
        self.tableViewOutlet.reloadData() // repopulates from central's shared [Property] array

    }
   
    
}

