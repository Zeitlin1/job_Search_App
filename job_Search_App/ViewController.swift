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
            make.bottom.equalTo(self.view).offset(-50)
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
        
        cell.businessNameLabel.snp.makeConstraints { (make) in
            make.width.equalTo(cell)
            make.centerX.equalTo(cell)
            make.top.equalTo(cell)
        }
        
        cell.CityLabel.snp.makeConstraints { (make) in
            make.width.equalTo(cell)
            make.centerX.equalTo(cell)
            make.bottom.equalTo(cell).multipliedBy(0.8)
        }
        
        cell.businessNameLabel.textColor = UIColor.blue
        cell.businessNameLabel.text = selectedArray[arrayIndex].name
        
        cell.CityLabel.textColor = UIColor.blue
        cell.CityLabel.text = selectedArray[arrayIndex].classification

        cell.backgroundColor = UIColor.white
        
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

