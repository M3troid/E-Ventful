//
//  HomeViewController.swift
//  E-Ventful
//
//  Created by Drake Neuenschwander on 1/19/22.
//

import UIKit
import Firebase
import FirebaseAuth


class HomeViewController: UIViewController {

    let userID = Auth.auth().currentUser?.uid
    
    var events = [Event]()
    
    @IBOutlet weak var tableViewEvents: UITableView! {
        didSet{
            tableViewEvents.dataSource = self
        }
    }
    @IBOutlet weak var circleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ref = DatabaseService.shared.eventRef.child(userID!).child("Events")
        ref.observe(.childAdded){ [weak self](snapshot) in
            let key = snapshot.key
            guard let value = snapshot.value as? [String : Any] else {return}
            if let eventName = value["eventName"] as? String, let eventFromDate = value["eventFromDate"] as? String {
                let event = Event(id: key, eventName: eventName, eventFromDate: eventFromDate)
                self?.events.append(event)
                if let row = self?.events.count {
                    let indexPath = IndexPath(row: row-1, section: 0)
                    self?.tableViewEvents.insertRows(at: [indexPath], with: .automatic)
                }
            }
        }
        
        
        
    }
  

    @IBAction func logOutButton_Tapped(_ sender: Any) {
        let auth = Auth.auth()
        
        do {
            try auth.signOut()
            let defaults = UserDefaults.standard
            defaults.set(false, forKey: "isUserSignedIn")
            self.dismiss(animated: true, completion: nil)
        } catch let signOutError {
            self.present(Service.createAlertController(title: "Error", message: signOutError.localizedDescription), animated: true, completion: nil)
        }
        
        print(self.events)
    }
}


extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return events.count
       }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let event = events[indexPath.row]
            //creating a cell using the custom class
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!
            EventTableViewCell
            
        cell.eventNameLabel?.text = event.eventName
        cell.eventFromDateLabel?.text = event.eventFromDate
            //returning cell
            return cell
        }
    }

