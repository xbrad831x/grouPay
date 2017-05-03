//
//  homeTabViewController.swift
//  grouPay
//
//  Created by Brandon on 4/26/17.
//  Copyright © 2017 Brandon. All rights reserved.
//

import UIKit

class homeTabViewController: UITabBarController {
    
    var userid: String!
    
    override func viewDidLoad() {
        let vc = self.viewControllers?[1] as! CreateViewController
        vc.id = self.userid
    }

}
