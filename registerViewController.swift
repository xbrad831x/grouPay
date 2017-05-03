//
//  registerViewController.swift
//  grouPay
//
//  Created by Brandon on 4/18/17.
//  Copyright © 2017 Brandon. All rights reserved.
//

import UIKit

class registerViewController: UIViewController, UITextViewDelegate, UIAlertViewDelegate {
    
    private var url = "http://192.168.1.117/api/register.php"
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    private var username: String = ""
    private var password: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        
        username = Username.text!
        password = Password.text!
        
        if(username.isEmpty)
        {
            let userNameAlert = UIAlertController(title: "Error", message: "Username blank.", preferredStyle: UIAlertControllerStyle.alert)
            
            userNameAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
                self.dismiss(animated: true, completion: nil)
                
            }))
                self.present(userNameAlert, animated: true, completion: nil)
            
            return
        }
        
        if(password.isEmpty)
        {
            let passwordAlert = UIAlertController(title: "Error", message: "Password blank", preferredStyle: UIAlertControllerStyle.alert)
            
            passwordAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
                self.dismiss(animated: true, completion: nil)
                
            }))
            self.present(passwordAlert, animated: true, completion: nil)
            
            return
        }
        
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
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: String], let value = json["value"] {
                    if(value == "Account Created")
                    {
                        let registerAlert = UIAlertController(title: "Registed", message: "Account Created.", preferredStyle: UIAlertControllerStyle.alert)
                        
                        registerAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
                            self.dismiss(animated: true, completion: nil)
                            
                        }))
                        DispatchQueue.main.async {
                            self.present(registerAlert, animated: true, completion: nil)
                        }
                    }
                    else if(value == "Account Exists")
                    {
                        let registerAlertError = UIAlertController(title: "Error", message: "Account Already Exists.", preferredStyle: UIAlertControllerStyle.alert)
                        
                        registerAlertError.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        
                        DispatchQueue.main.async {
                            self.present(registerAlertError, animated: true, completion: nil)
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
