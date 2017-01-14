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


class PropertyListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var central = CentralDataStore.shared
   
    @IBOutlet weak var tableViewOutlet: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(PropertyListViewController.reloadView),name:NSNotification.Name(rawValue: "load"), object: nil)
        
        central.loadCentralArray {}

        let titleText = "Your Lineup"
        
        let nav = self.navigationController?.navigationBar

        setupNavBar(bar: nav!, text: titleText)

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

        self.tableViewOutlet.reloadData()
    
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
        
        cell.backgroundColor = UIColor.clear
        
        cell.selectionStyle = .default
        
        if central.properties[indexPath.row].warmLead {
            
            cell.backgroundColor = UIColor.red.withAlphaComponent(0.25)
        
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        TipInCellAnimator.animate(cell: cell) {}
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "propertyDetailSegue" {
         
            if let dest = segue.destination as? PropertyDetailViewController, let indexPath = tableViewOutlet.indexPathForSelectedRow {
                
                self.central.currentProperty = central.properties[(indexPath as NSIndexPath).row]
                
                dest.property = central.currentProperty
            }
        }
    }
    
    func setCell(cell: TableViewCell, index: Int) {
        
        cell.buffBarIcons.text = "🔥🍀☎️⚡️"
        cell.lastCalledText.text = central.properties[index].callDate
        cell.propertyNameText.text = central.properties[index].buildingAddress
        cell.lastCalledText.text = central.properties[index].callDate
        
        if central.properties[index].callDate != "Ready"  {
            cell.lastCalledText.textColor = UIColor.white
        } else {
            cell.lastCalledText.textColor = UIColor.green
        }

    }
    
    func reloadView() {
        
        self.tableViewOutlet.reloadData()

    }

   
    
}

