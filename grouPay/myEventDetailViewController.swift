//
//  myEventDetailViewController.swift
//  grouPay
//
//  Created by Brandon on 5/11/17.
//  Copyright © 2017 Brandon. All rights reserved.
//

import UIKit

class myEventDetailViewController: UIViewController {
    
    var event: Event?

    @IBOutlet weak var TitleText: UILabel!
    @IBOutlet weak var DescriptionText: UITextView!
    @IBOutlet weak var OwnerText: UILabel!
    @IBOutlet weak var AmountText: UILabel!
    @IBOutlet weak var CreatedText: UILabel!
    @IBOutlet weak var DueText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TitleText.text = event?.title
        DescriptionText.text = event?.description
        OwnerText.text = event?.ownername
        AmountText.text = event?.amount
        CreatedText.text = event?.created
        DueText.text = event?.due
    }
    
    @IBAction func dismissDetail(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
