//
//  EventViewCell.swift
//  grouPay
//
//  Created by Brandon on 5/5/17.
//  Copyright © 2017 Brandon. All rights reserved.
//

import UIKit

class EventViewCell: UITableViewCell {
    
    
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var Owner: UILabel!
    @IBOutlet weak var Due: UILabel!
    @IBOutlet weak var OwnerLabel: UILabel!
    @IBOutlet weak var DueLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
