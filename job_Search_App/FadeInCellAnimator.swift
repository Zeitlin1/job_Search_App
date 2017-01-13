//
//  FadeInCellAnimator.swift
//  job_Search_App
//
//  Created by Anthony on 1/10/17.
//  Copyright © 2017 Anthony. All rights reserved.
//

import Foundation
import UIKit

class TipInCellAnimator {
    
    class func animate(cell: UITableViewCell, completion: () -> Void) {
        
        let view = cell.contentView
        
        view.layer.opacity = 0.0
        
        
        UIView.animate(withDuration: 0.3) {
            
            view.layer.opacity = 1
        }
        completion()
    }
}
