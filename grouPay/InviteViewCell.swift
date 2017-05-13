//
//  InviteViewCell.swift
//  grouPay
//
//  Created by Brandon on 5/8/17.
//  Copyright © 2017 Brandon. All rights reserved.
//

import UIKit

class InviteViewCell: UITableViewCell {
    
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var OwnerLabel: UILabel!
    @IBOutlet weak var AmountLabel: UILabel!
    @IBOutlet weak var DueLabel: UILabel!
    @IBOutlet weak var Owner: UILabel!
    @IBOutlet weak var Amount: UILabel!
    @IBOutlet weak var Due: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
