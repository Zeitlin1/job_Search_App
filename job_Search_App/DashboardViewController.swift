//
//  ManagerViewController.swift
//  job_Search_App
//
//  Created by Anthony on 12/29/16.
//  Copyright © 2016 Anthony. All rights reserved.
//

import UIKit
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
    
    @IBOutlet weak var downloadEmailButton: UIButton!
    
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var exit: UIButton!
    
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
       
        
        chartLabel.snp.makeConstraints { (make) in
            make.width.equalTo(self.view).multipliedBy(0.95)
            make.top.equalTo(self.chartBorderLabel.snp.topMargin)
            make.centerX.equalTo(self.view)
            make.height.equalTo(220)
        }
   
        statsBoardLabel.snp.makeConstraints { (make) in
            make.width.equalTo(chartLabel)
            make.top.equalTo(chartBorderLabel.snp.bottom)
            make.centerX.equalTo(self.view)
            make.height.equalTo(chartLabel.snp.height)
        }
        
        tableViewOutlet.snp.makeConstraints { (make) in
            make.width.equalTo(statsBoardLabel)
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(statsBoardLabel)
            make.top.equalTo(chartBorderLabel.snp.bottom)
            make.bottom.equalTo(uploadNEWbuttonLabel.snp.top).offset(-10)
        }
        
        
        uploadNEWbuttonLabel.snp.makeConstraints { (make) in
            
            make.width.equalTo(160)
            make.height.equalTo(50)
            make.top.equalTo(tableViewOutlet.snp.bottom).offset(10)
            make.left.equalTo(self.tableViewOutlet.snp.left).offset(0)
            
        }
        
        
        
        upload_buttonLabel.snp.makeConstraints { (make) in
            make.width.equalTo(160)
            make.height.equalTo(50)
            make.top.equalTo(tableViewOutlet.snp.bottom).offset(10)
            make.right.equalTo(self.tableViewOutlet.snp.right).offset(0)
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
       
        return cell
    }
    
    @IBAction func exitButton(_ sender: Any) {
        UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
    }
    
//    @IBAction func downloadEmailsButton(_ sender: Any) {
//        ActivityIndicator.startAnimating()
//        central.getEmailDataFromApi(urlString: hunterAPIkeyDOMAIN_Search) {
//            self.ActivityIndicator.stopAnimating()
//        }
//    }
    
    @IBAction func loadLeadsButton(_ sender: Any) {
        ActivityIndicator.startAnimating()
        print("yellow")
        central.reloadCentralArray {
            
        }
        
    }
    
    @IBAction func uploadLeadsButton(_ sender: Any) {
        print("red")
        
        ActivityIndicator.startAnimating()
        
        central.getBusinessDataFromApi {
        
        self.ActivityIndicator.stopAnimating()
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }
        
    }
//        func createGradientLayer(cell: UITableViewCell) {
//    
//            let gradientLayer = CAGradientLayer()
//    
//            cell.backgroundView = UIView()
//    
//            gradientLayer.frame = cell.bounds
//    
//            gradientLayer.colors = [UIColor.black.cgColor.copy(alpha: 0.5), UIColor.black.cgColor.copy(alpha: 0.6)]
//    
//            cell.backgroundView?.layer.insertSublayer(gradientLayer, at: 0)
//            
//            
//        }
//    
    
}
