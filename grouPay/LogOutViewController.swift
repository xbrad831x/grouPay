//
//  LogOutViewController.swift
//  grouPay
//
//  Created by Brandon on 5/8/17.
//  Copyright © 2017 Brandon. All rights reserved.
//

import UIKit

class LogOutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Logout(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    

}
