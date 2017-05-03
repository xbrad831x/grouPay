//
//  homeViewController.swift
//  grouPay
//
//  Created by Brandon on 4/21/17.
//  Copyright © 2017 Brandon. All rights reserved.
//

import UIKit

class homeViewController: UIViewController {
    
    @IBOutlet weak var displayName: UILabel!
    var userid: String = ""
    private var url = "http://192.168.1.117/api/home.php"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    

    @IBAction func LogOut(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
   

}
