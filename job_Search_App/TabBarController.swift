//
//  TabBarController.swift
//  job_Search_App
//
//  Created by Anthony on 1/7/17.
//  Copyright © 2017 Anthony. All rights reserved.
//

import UIKit
import SnapKit

class TabBarController: UITabBarController {

    @IBOutlet weak var mainTabBar: UITabBar!
  
    override func viewDidLoad() {
        
        super.viewDidLoad()

//        let tap = UITapGestureRecognizer(target: self, action: #selector(TabBarController.reactToTouch))
        
        mainTabBar.barStyle = UIBarStyle.default
        
      
        
        mainTabBar.backgroundColor = UIColor.red
        
        print(mainTabBar.items?[0])
        
        print(mainTabBar.items?[1])
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reactToTouch() {
        if let dash = mainTabBar.items?[0],
           let list = mainTabBar.items?[1],
           let warm = mainTabBar.items?[2]
        {
            
            print("You Touched Me")
        }
    }
}
