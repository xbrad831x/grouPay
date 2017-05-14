//
//  CreateViewController.swift
//  grouPay
//
//  Created by Brandon on 4/28/17.
//  Copyright © 2017 Brandon. All rights reserved.
//

import UIKit

extension Date {
    var localTime: String {
        return description(with: Locale.current)
    }
}

class CreateViewController: UIViewController {
    
    @IBOutlet weak var TitleText: UITextField!
    @IBOutlet weak var Amount: UITextField!
    @IBOutlet weak var People: UITextField!
    @IBOutlet weak var Description: UITextView!
    @IBOutlet weak var Date: UIDatePicker!
    
    private var url = "http://192.168.1.117/api/create_event.php"
    var id: String!
    
    
    private var titleEvent: String!
    private var amount: String!
    private var people: String!
    private var describing: String!
    private var dueDate: String!
    private var isPrivate: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func getTime(_ sender: UIDatePicker) {
        
        let date = sender.date
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        dueDate = dateFormatter.string(from: date)
        
    }
    
    
    @IBAction func IsPublic(_ sender: UIButton) {
        isPrivate = false
    }
    
    
    @IBAction func IsPrivate(_ sender: UIButton) {
        isPrivate = true
    }
    
    
    @IBAction func Create(_ sender: UIButton) {
        titleEvent = TitleText.text!
        people = People.text!
        describing = Description.text!
        
        if(titleEvent.isEmpty)
        {
            
            let titleAlert = UIAlertController(title: "Error", message: "Title Blank.", preferredStyle: UIAlertControllerStyle.alert)
            
            titleAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
                titleAlert.dismiss(animated: true, completion: nil)
                
            }))
            self.present(titleAlert, animated: true, completion: nil)
            
            return
        }
        else if(describing.isEmpty)
        {
            
            let descriptionAlert = UIAlertController(title: "Error", message: "No Description entered.", preferredStyle: UIAlertControllerStyle.alert)
            
            descriptionAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
                descriptionAlert.dismiss(animated: true, completion: nil)
                
            }))
            self.present(descriptionAlert, animated: true, completion: nil)
            
            return
        }
        
        if Double(Amount.text!) != nil
        {
            amount = Amount.text!
        }
        else
        {
            let amountAlert = UIAlertController(title: "Error", message: "The amount entered is not a valid number.", preferredStyle: UIAlertControllerStyle.alert)
            
            amountAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
                amountAlert.dismiss(animated: true, completion: nil)
                
            }))
            self.present(amountAlert, animated: true, completion: nil)
            
            return
        }
        
        if(dueDate == nil)
        {
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dueDate = dateFormat.string(from: Date.date)
        }
        
        let u = URL(string: url)
        var request = URLRequest(url: u!)
        request.httpMethod = "POST"
        let postString = "Owner=\(id!)&Title=\(titleEvent!)&Amount=\(amount!)&People=\(people!)&Description=\(describing!)&Date=\(dueDate!)&Privacy=\(isPrivate)"
        request.httpBody = postString.data(using: .utf8)
        print (postString)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("request failed \(error)")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: String] {
                    if(json["value"] == "success")
                    {
                        let eventAlert = UIAlertController(title: "Success", message: "The event was created.", preferredStyle: UIAlertControllerStyle.alert)
                        
                        eventAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
                            eventAlert.dismiss(animated: true, completion: nil)
                            
                        }))
                        DispatchQueue.main.async {
                            self.present(eventAlert, animated: true, completion: nil)
                        }
                        
                        return
                    }
                    else
                    {
                        let eventAlert = UIAlertController(title: "Error", message: "An error has occured. Event was not created", preferredStyle: UIAlertControllerStyle.alert)
                        
                        eventAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
                            eventAlert.dismiss(animated: true, completion: nil)
                            
                        }))
                        DispatchQueue.main.async {
                            self.present(eventAlert, animated: true, completion: nil)
                        }
                        
                        return
                    }
                }
            } catch let parseError {
                print("parsing error: \(parseError)")
                let responseString = String(data: data, encoding: .utf8)
                print("raw response: \(responseString)")
            }
        }
        task.resume()
    }
}
