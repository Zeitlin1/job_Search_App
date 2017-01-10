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
        
        let titleText = "Your Lineup"
        
        let nav = self.navigationController?.navigationBar

        setupNavBar(bar: nav!, text: titleText)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LeadListViewController.reloadView),name:NSNotification.Name(rawValue: "load"), object: nil)
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(PropertyDetailViewController.dismissKeyboard))
//
//        self.view.addGestureRecognizer(tap)

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
        tableViewOutlet.separatorEffect = UIBlurEffect(style: .prominent)
        tableViewOutlet.separatorColor = UIColor.white
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

        setCell(cell: cell, index: indexPath.row)

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        TipInCellAnimator.animate(cell: cell) { 
            
            let view = cell.contentView
            
            view.layer.opacity = 0.5
            
            UIView.animate(withDuration: 0.7) {
                print("animating")
                view.layer.opacity = 1
            }

        }
    }

    // passes chosen property's info to detail view (orig. from prop array)
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "propertyDetailSegue" {
         
            if let dest = segue.destination as? PropertyDetailViewController, let indexPath = tableViewOutlet.indexPathForSelectedRow {
             
                dest.property = central.properties[(indexPath as NSIndexPath).row]
                
            }
        }
    }
    
    func setCell(cell: TableViewCell, index: Int) {
        
        if central.properties[index].numberOfCallsTo > 0 {
            cell.backgroundColor = UIColor.red.withAlphaComponent(0.1)
        }
    
        cell.lastCalledText.text = central.properties[index].callDate
        cell.addressText.text = central.properties[index].buildingAddress
        cell.ownerText.text = central.properties[index].ownerName
        cell.propTitleLabel.text = central.properties[index].buildingAddress
        cell.backgroundColor = UIColor.clear
        

    }
    
    func reloadView() {
        
        self.tableViewOutlet.reloadData() // repopulates from central's shared [Property] array

    }

   
    
}

