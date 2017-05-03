//
//  ViewController.swift
//  grouPay
//
//  Created by Brandon on 4/17/17.
//  Copyright © 2017 Brandon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    private var url = "http://192.168.1.117/api/login.php"
    
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var ErrorText: UILabel!
    @IBOutlet weak var success: UILabel!
    private var username: String = ""
    private var password: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func Login(_ sender: UIButton) {
        username = Username.text!
        password = Password.text!
        let u = URL(string: url)
        var request = URLRequest(url: u!)
        request.httpMethod = "POST"
        let postString = "Username=\(username)&Password=\(password)"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("request failed \(error)")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: String] {
                    if(json["value"] == "true")
                    {
                        let myVC = self.storyboard?.instantiateViewController(withIdentifier: "homeTab") as! homeTabViewController
                        myVC.userid = json["id"]!
                        DispatchQueue.main.async {
                            self.Username.text = ""
                            self.Password.text = ""
                           self.present(myVC, animated: true)
                        }
                    }
                    else
                    {
                        let loginAlertError = UIAlertController(title: "Error", message: "Invalid Login.", preferredStyle: UIAlertControllerStyle.alert)
                        
                        loginAlertError.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        
                        DispatchQueue.main.async {
                            self.present(loginAlertError, animated: true, completion: nil)
                        }
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

