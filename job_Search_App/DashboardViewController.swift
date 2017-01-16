//
//  ManagerViewController.swift
//  job_Search_App
//
//  Created by Anthony on 12/29/16.
//  Copyright © 2016 Anthony. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage


class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let central = CentralDataStore.shared
    
    var chartInfo: [String: (String, String)] = [
        
        "0": ("Total Calls", "234"),
        "1": ("$ Generated", "$385,348"),
        "2": ("Hit Rate", "3.4%"),
        "3": ("Avg Call Length", "3 Min"),
        "4": ("Last Call", "Tue Jan, 1"),
        "5": ("Longest Call", "35 Min"),
        "6": ("Calls this Week", "156"),
        "7": ("Hangups", "13"),
        "8": ("Score", "7.76")
    ]
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    @IBOutlet weak var uploadNEWbuttonLabel: UIButton!
    
    @IBOutlet weak var upload_buttonLabel: UIButton!
    
    @IBOutlet weak var searchEmailButton: UIButton!
    
    @IBOutlet weak var searchEmailLabel: UIButton!
    
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var exit: UIButton!
    
    @IBOutlet weak var exitLabel: UIButton!
    
    @IBOutlet weak var chartLabel: UILabel!
    
    @IBOutlet weak var chartBorderLabel: UILabel!
    
    @IBOutlet weak var statsBoardLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ActivityIndicator.stopAnimating()
        
        self.tableViewOutlet.delegate = self
        
        self.tableViewOutlet.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.startIndicator),name:NSNotification.Name(rawValue: "startIndicator"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.stopIndicator),name:NSNotification.Name(rawValue: "stopIndicator"), object: nil)
       
        createGradientLayer(on: self.view)
            
        chartLabel.snp.makeConstraints { (make) in
            make.width.equalTo(self.view).multipliedBy(0.95)
            make.centerY.equalTo(self.chartBorderLabel.snp.centerY)
            make.centerX.equalTo(self.view)
            make.height.equalTo(chartLabel.snp.width).multipliedBy(0.6)
            chartLabel.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
            chartLabel.layer.borderColor = UIColor.white.cgColor
            self.view.bringSubview(toFront: chartLabel)
        }
        
        chartBorderLabel.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(chartLabel.snp.height).multipliedBy(1.1)
            make.top.equalTo(self.view).offset(20)
            make.centerX.equalTo(self.view)
        }
        
        tableViewOutlet.snp.makeConstraints { (make) in
            make.width.equalTo(chartLabel.snp.width)
            make.top.equalTo(chartBorderLabel.snp.bottom)
            make.height.equalTo(chartLabel.snp.height)
            make.centerX.equalTo(self.view)
            tableViewOutlet.backgroundColor = UIColor.clear
        }
        
        tableViewOutlet.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        tableViewOutlet.separatorColor = UIColor.white.withAlphaComponent(0.3)
        tableViewOutlet.preservesSuperviewLayoutMargins = false
        tableViewOutlet.separatorInset = UIEdgeInsets.zero
        tableViewOutlet.layoutMargins = UIEdgeInsets.zero

   
        statsBoardLabel.snp.makeConstraints { (make) in
            make.width.equalTo(tableViewOutlet.snp.width)
            make.top.equalTo(tableViewOutlet.snp.top)
            make.left.equalTo(tableViewOutlet.snp.left)
            make.right.equalTo(tableViewOutlet.snp.right)
            make.height.equalTo(tableViewOutlet.snp.height)
            statsBoardLabel.backgroundColor = UIColor.clear
        }
                        ///* button layouts *///
        
        uploadNEWbuttonLabel.snp.makeConstraints { (make) in
            
            make.width.equalTo(self.view).multipliedBy(0.4)
            make.height.equalTo(uploadNEWbuttonLabel.snp.width).multipliedBy(0.3)
            make.top.equalTo(tableViewOutlet.snp.bottom).offset(10)
            make.left.equalTo(self.tableViewOutlet.snp.left).offset(20)
            uploadNEWbuttonLabel.layer.borderColor = UIColor.white.cgColor
            createGlow(button: uploadNEWbuttonLabel)
        }
        
        upload_buttonLabel.snp.makeConstraints { (make) in
            make.width.equalTo(uploadNEWbuttonLabel.snp.width)
            make.height.equalTo(uploadNEWbuttonLabel.snp.height)
            make.top.equalTo(uploadNEWbuttonLabel.snp.top)
            make.right.equalTo(self.tableViewOutlet.snp.right).offset(-20)
            upload_buttonLabel.layer.borderColor = UIColor.white.cgColor
            createGlow(button: upload_buttonLabel)
        }
        
        searchEmailLabel.snp.makeConstraints { (make) in
            
            make.width.equalTo(uploadNEWbuttonLabel.snp.width)
            make.height.equalTo(uploadNEWbuttonLabel.snp.height)
            make.top.equalTo(uploadNEWbuttonLabel.snp.bottom).offset(10)
            make.left.equalTo(uploadNEWbuttonLabel.snp.left)
            searchEmailLabel.layer.borderColor = UIColor.white.cgColor
            createGlow(button: searchEmailLabel)
        }
        
        exitLabel.snp.makeConstraints { (make) in
            
            make.width.equalTo(uploadNEWbuttonLabel.snp.width)
            make.height.equalTo(uploadNEWbuttonLabel.snp.height)
            make.top.equalTo(upload_buttonLabel.snp.bottom).offset(10)
            make.right.equalTo(upload_buttonLabel.snp.right)
            exitLabel.layer.borderColor = UIColor.white.cgColor
            createGlow(button: exitLabel)
        }
       
    }
    func startIndicator() {
        ActivityIndicator.startAnimating()
    }
    
    func stopIndicator() {
        ActivityIndicator.stopAnimating()
        
    }
//
  
//    
//    func uploadCSV() {
//        
//        // Create a reference to local data source file
//        if let uploadFile = URL(string: firebaseStorageTestJson) {
//        
//        // Create a root reference
//        let storageRef = storage.reference()
//        
//        // Create a reference to the root's child
//        let child = storageRef.child(firstChild)
//       
//        
//            let uploadTask = child.putFile(uploadFile)
//            if let error = error {
//             
//                print(error)
//                print("ERROR")
//            } else {
//                // Metadata contains file metadata such as size, content-type, and download URL.
//                let downloadURL = metadata!.downloadURL()
//                print(downloadURL?.absoluteString)
//                print("NO ERROR")
//            }
//        }
//        }
//    }
//
//
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return self.chartInfo.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "statCell", for: indexPath) as! DashboardTableViewCell
    
        let arrayIndex = String(indexPath.row)
        
        cell.statNameLabel.text = self.chartInfo[arrayIndex]?.0
        
        cell.statText.text = self.chartInfo[arrayIndex]?.1
        
        cell.backgroundColor = UIColor.clear
       
        return cell
    }
    
    @IBAction func exitButton(_ sender: Any) {
        UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
    }
   
    @IBAction func searchEmailsPushed(_ sender: Any) { }


    @IBAction func downloadLineupPushed(_ sender: Any) {
        ActivityIndicator.startAnimating()
        
        central.loadCentralArray {
            
        }
    }
    
    @IBAction func uploadFilePushed(_ sender: Any) {
        
        ActivityIndicator.startAnimating()
        
        central.getBusinessDataFromApi {
            
            self.ActivityIndicator.stopAnimating()
        }
        
    }
    
    
}
