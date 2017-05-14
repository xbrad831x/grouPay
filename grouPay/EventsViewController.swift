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
            cell.OwnerLabel.text = "Owner:"
            cell.DueLabel.text = "Due:"
            
        }
        else
        {
            cell.Owner.text = ""
            cell.eventTitle.text = "No Events Available"
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
                            
                            if let people = eventData["People"] as String!
                                {
                                event.people = people
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let detailView = sb.instantiateViewController(withIdentifier: "eventdetail") as! myEventDetailViewController
        detailView.event = events[indexPath.row]
        self.present(detailView, animated: true, completion: nil)
    }
    

}
