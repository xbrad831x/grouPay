//
//  homeTabViewController.swift
//  grouPay
//
//  Created by Brandon on 4/26/17.
//  Copyright © 2017 Brandon. All rights reserved.
//

import UIKit

class homeTabViewController: UITabBarController, UITabBarControllerDelegate {
    
    let cvc: CreateViewController! = nil
    
    var userid: String!
    
    override func viewDidLoad() {
        self.delegate = self
        
        let cvc = self.viewControllers?[1] as! CreateViewController
        cvc.id = self.userid
        
        let evvc = self.viewControllers?[0] as! EventsViewController
        evvc.id = self.userid
        
    }

}
