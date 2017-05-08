//
//  EventsViewController.swift
//  grouPay
//
//  Created by Brandon on 5/5/17.
//  Copyright © 2017 Brandon. All rights reserved.
//

import UIKit

class EventsViewController: UITableViewController {
    
    private var url = "http://192.168.1.117/api/retrieve_events.php"
    var id: String!
    var events: [Event] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        load_data()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(events.count < 1)
        {
            return 1
        }
        else
        {
            return events.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventcell", for: indexPath) as! EventViewCell
        
        if (events.count > 0)
        {
            let e = events[indexPath.row]
            cell.Owner.text = e.ownername
            cell.eventTitle.text = e.title
            cell.Due.text = e.due
            
        }
        else
        {
            cell.Owner.text = ""
            cell.eventTitle.text = ""
            cell.Due.text = ""
            cell.DueLabel.text = ""
            cell.OwnerLabel.text = ""
        }
        
        return cell
    }
    
    func load_data() {
        events.removeAll()
        let u = URL(string: url)
        var request = URLRequest(url: u!)
        request.httpMethod = "POST"
        let postString = "id=\(self.id!)"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("request failed \(error)")
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data , options: []) as? [String: Any] {
                    
                    if(json.count > 0)
                    {
                        
                        let parsedjson = json["Events"] as! [[String: String]]
                        
                        for eventData in parsedjson
                        {
                            let event = Event()
                            
                            if let id = eventData["EventId"] as String!{
                                event.eventid = id
                            }
                            
                            if let name = eventData["OwnerName"] as String! {
                                event.ownername = name
                            }
                            
                            if let title = eventData["Title"] as String! {
                                event.title = title
                            }
                            
                            if let description = eventData["Description"] as String! {
                                event.description = description
                            }
                            
                            if let created = eventData["Created"] as String! {
                                event.created = created
                            }
                            
                            if let due = eventData["Due"] as String! {
                                event.due = due
                            }
                            
                            if let amount = eventData["Amount"] as String! {
                                event.amount = amount
                            }

                            self.events.append(event)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                    else
                    {
                        print("Error")
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
