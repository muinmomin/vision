//
//  InfoTableViewController.swift
//  AR Portal
//
//  Created by Mike Choi on 11/19/17.
//  Copyright © 2017 Somnibyte. All rights reserved.
//

import Foundation
import UIKit

class InfoTableViewController: UITableViewController {
    
    @IBAction func callNumber(_ sender: Any) {
        let url: NSURL = URL(string: "TEL://1231112222")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    
    override func viewDidLoad() {
        tableView.tableFooterView = UIView()
        
        tableView.backgroundColor = UIColor.clear
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        tableView.backgroundView = blurEffectView
        
        //if inside a popover
        if let popover = navigationController?.popoverPresentationController {
            popover.backgroundColor = UIColor.clear
        }
        
        //if you want translucent vibrant table view separator lines
        tableView.separatorEffect = UIVibrancyEffect(blurEffect: blurEffect)
    }
}
