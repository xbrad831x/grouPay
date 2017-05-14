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
    var userid: String?
    private var url = "http://192.168.1.117/api/invite_response.php"

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
        InviteDescription.isEditable = false
    }
    
    @IBAction func Dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func Decline(_ sender: UIButton) {
        let u = URL(string: url)
        var request = URLRequest(url: u!)
        request.httpMethod = "POST"
        let postString = "userid=\(self.userid!)&eventid=\(self.event!.eventid)&response=no&amountdue=0"
        print(postString)
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data,
                let html = String(data: data, encoding: String.Encoding.utf8) {
                print(html)
            }
        }
        task.resume()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Accept(_ sender: UIButton) {
        let u = URL(string: url)
        var request = URLRequest(url: u!)
        request.httpMethod = "POST"
        let postString = "userid=\(self.userid!)&eventid=\(self.event!.eventid)&response=yes&amountdue=\(self.event!.amountneed)"
        print(postString)
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data,
                let html = String(data: data, encoding: String.Encoding.utf8) {
                print(html)
            }
        }
        task.resume()
        self.dismiss(animated: true, completion: nil)
    }
}
