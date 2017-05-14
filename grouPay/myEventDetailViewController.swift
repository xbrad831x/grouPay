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
    var people: [String]?

    @IBOutlet weak var TitleText: UILabel!
    @IBOutlet weak var DescriptionText: UITextView!
    @IBOutlet weak var OwnerText: UILabel!
    @IBOutlet weak var AmountText: UILabel!
    @IBOutlet weak var CreatedText: UILabel!
    @IBOutlet weak var DueText: UILabel!
    @IBOutlet weak var ParticipantText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TitleText.text = event?.title
        DescriptionText.text = event?.description
        OwnerText.text = event?.ownername
        AmountText.text = event?.amount
        CreatedText.text = event?.created
        DueText.text = event?.due
        
        if(event?.people.isEmpty)!
        {
            DescriptionText.isEditable = false
            return
        }
        else
        {
            people = event?.people.components(separatedBy: ",")
            
            if(people!.count > 0)
            {
                for person in people! {
                    let updated = person.replacingOccurrences(of: "[", with: "")
                    let updated2 = updated.replacingOccurrences(of: "]", with: "")
                    let updated3 = updated2.replacingOccurrences(of: "{", with: "")
                    let updated4 = updated3.replacingOccurrences(of: "}", with: "")
                    let updated5 = updated4.replacingOccurrences(of: "\"", with: "")
                    
                    let array = updated5.components(separatedBy: ":")
                    
                    ParticipantText.text = ParticipantText.text + array[0] + " owes $" + array[1] + "\n"
                }
            }
        }
        DescriptionText.isEditable = false
    }
    
    @IBAction func dismissDetail(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
