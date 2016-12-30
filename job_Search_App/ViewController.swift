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


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let dataStore = PropertyDataStore.sharedInstance
    
    let store = CoreDataStack.shared
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    @IBOutlet weak var findBusinessLabel: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableViewOutlet.delegate = self
        
        self.tableViewOutlet.dataSource = self
        
        self.view.backgroundColor = UIColor.lightGray
        
        tableViewOutlet.snp.makeConstraints { (make) in // to constrain properly it needs 4x different constraints made
            make.width.equalTo(self.view)
            make.height.equalTo(self.view).multipliedBy(0.75)
            make.left.equalTo(self.view)
            make.top.equalTo(self.view).offset(65)
        }
        
        findBusinessLabel.snp.makeConstraints { (make) in
            make.width.equalTo(175)
            make.height.equalTo(50)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(tableViewOutlet).offset(75)
            findBusinessLabel.layer.borderColor = UIColor.blue.cgColor
            findBusinessLabel.layer.borderWidth = 2
            findBusinessLabel.layer.cornerRadius = 5
        }
        
        tableViewOutlet.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        tableViewOutlet.separatorColor = UIColor.red
        tableViewOutlet.preservesSuperviewLayoutMargins = false
        tableViewOutlet.separatorInset = UIEdgeInsets.zero
        tableViewOutlet.layoutMargins = UIEdgeInsets.zero

    }

    override func viewWillAppear(_ animated: Bool) {
        self.tableViewOutlet.reloadData()
    }
    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return dataStore.properties.count
        
    }
  
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "propertyCell", for: indexPath) as! TableViewCell
        
        let arrayIndex = indexPath.row
        
        let selectedArray = dataStore.properties
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        cell.businessNameLabel.snp.makeConstraints { (make) in
            make.width.equalTo(cell)
            make.centerX.equalTo(cell)
            make.top.equalTo(cell).offset(5)
        }
        
        cell.CityLabel.snp.makeConstraints { (make) in
            make.width.equalTo(cell)
            make.centerX.equalTo(cell)
            make.top.equalTo(cell.businessNameLabel).offset(18)
        }
        cell.lastCalledLabel.snp.makeConstraints { (make) in
            make.width.equalTo(cell).multipliedBy(0.5)
            make.left.equalTo(cell)
            make.bottom.equalTo(cell).offset(-5)
        }
        cell.lastCalledText.snp.makeConstraints { (make) in
            make.width.equalTo(cell).multipliedBy(0.5)
            make.right.equalTo(cell)
            make.bottom.equalTo(cell).offset(-5)
        }
        
        cell.warmLeadImage.snp.makeConstraints { (make) in
            make.width.equalTo(cell).multipliedBy(0.1)
            make.height.equalTo(cell).multipliedBy(0.7)
            make.centerX.equalTo(cell)
            make.bottom.equalTo(cell).offset(-2)
            cell.warmLeadImage.alpha = 0.5
        }
        
        cell.businessNameLabel.textColor = UIColor.blue
        cell.lastCalledText.textColor = UIColor.blue
        cell.lastCalledLabel.textColor = UIColor.blue
        cell.CityLabel.textColor = UIColor.blue
        
        if let bAddress = selectedArray[arrayIndex].buildingAddress {
            cell.businessNameLabel.text = bAddress
        }
        
        if let callDate = selectedArray[arrayIndex].callDate {
            cell.lastCalledText.text = String(describing: dateFormatter.string(from: callDate as Date))
        } else { cell.lastCalledText.text = "" }
        
        cell.CityLabel.text = selectedArray[arrayIndex].ownerName

        cell.backgroundColor = UIColor.white
        
        if selectedArray[arrayIndex].warmLead == true {
            cell.backgroundColor = UIColor.red.withAlphaComponent(0.1)
            cell.warmLeadImage.isHidden = false
        } else {
            cell.backgroundColor = UIColor.clear
            cell.warmLeadImage.isHidden = true
        }
        
        
        return cell
        
    }


   
    @IBAction func findBusinessButton(_ sender: Any) {
        
        dataStore.getBusinessDataFromApi {
           
            DispatchQueue.main.async {
                // load core data here
                self.store.retrieveCoreDataNotes(notesArray: self.dataStore.properties)
                self.tableViewOutlet.reloadData()
            
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "propertyDetailSegue" {
            print("SEGUE 2")
            if let dest = segue.destination as? PropertyDetailViewController, let indexPath = tableViewOutlet.indexPathForSelectedRow {
                print("SEGUE 3")
                dest.property = dataStore.properties[(indexPath as NSIndexPath).row]
                print("SEGUE 4")
                print("AFTER DEST PROP SET")
                
            }
        }
    }
    
}

