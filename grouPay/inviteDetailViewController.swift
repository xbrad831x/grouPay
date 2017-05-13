//
//  inviteDetailViewController.swift
//  grouPay
//
//  Created by Brandon on 5/11/17.
//  Copyright © 2017 Brandon. All rights reserved.
//

import UIKit

class inviteDetailViewController: UIViewController {
    
    var event: Event?

    @IBOutlet weak var InviteTitle: UILabel!
    @IBOutlet weak var InviteDescription: UITextView!
    @IBOutlet weak var InviteOwner: UILabel!
    @IBOutlet weak var InviteTotal: UILabel!
    @IBOutlet weak var InviteCreated: UILabel!
    @IBOutlet weak var InvitedDue: UILabel!
    @IBOutlet weak var InvitedAmountNeed: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        InviteTitle.text = event?.title
        InviteDescription.text = event?.description
        InviteOwner.text = event?.ownername
        InviteTotal.text = event?.amount
        InviteCreated.text = event?.created
        InvitedDue.text = event?.due
        InvitedAmountNeed.text = event?.amountneed
    }
    
    @IBAction func Dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
