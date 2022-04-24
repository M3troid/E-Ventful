//
//  HomeViewController.swift
//  E-Ventful
//
//  Created by Drake Neuenschwander on 1/19/22.
// This view is the main home view that allows for mutiple functions to be run and a general housing for information from the user.
//

//imports to allow for connection to firebase and for authentiction
import UIKit
import Firebase
import FirebaseAuth


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //global variables for this view.
    let userID = Auth.auth().currentUser?.uid
    var events = [Event]()
    
    @IBOutlet weak var tableViewEvents: UITableView! {
        didSet{
            tableViewEvents.dataSource = self
            tableViewEvents.delegate = self
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
    
        
    }
    override func viewDidLoad() {
            super.viewDidLoad()
    //refreshes the view of the home table.
        let ref = DatabaseService.shared.eventRef.child(userID!).child("Events")
        ref.observe(.childAdded){ [weak self](snapshot) in
            let key = snapshot.key
            guard let value = snapshot.value as? [String : Any] else {return}
            if let eventName = value["eventName"] as? String, let eventFromDate = value["eventFromDate"] as? String, let randomID = value["randomID"] as? String, let eventToDate = value["eventToDate"] as? String{
                
                //This code is a possible implementation in the future.
                //, let selectionEvent = value["activity"] as? [String], let selectionTime = value["time"] as? [String], let selectionName = value["attendeeName"] as? [String], let selectionNumber = value["attendeeNumber"] as? [String]{
                let event = Event(id: key, eventName: eventName, eventFromDate: eventFromDate, randomID: randomID, eventToDate: eventToDate)//, selectionName: selectionName, selectionTime: selectionTime, selectionEvent: selectionEvent, selectionNumber: selectionNumber)
                self?.events.append(event)
                if let row = self?.events.count {
                    let indexPath = IndexPath(row: row-1, section: 0)
                    self?.tableViewEvents.insertRows(at: [indexPath], with: .automatic)
                }
                
            }
        }
    }
        
    // sets the height parameter for the table cells on the homeview.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0;//custom row height
    }
    //sets the amount of cells int he homeview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return events.count
       }
    //sets the data for the cells
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
    //action for the event a user wants to delete the event
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let event = events[indexPath.row]
            let randomIDEvent = event.randomID
            events.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            DatabaseService.shared.eventRef.child(userID!).child("Events").child(randomIDEvent).removeValue()
        } else if editingStyle == .insert {
            
        }
    }
    //action for the event a user taps on a cell to modify the data.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let MvC = Storyboard.instantiateViewController(withIdentifier: "ModifyEventViewController") as! ModifyEventViewController
        
        MvC.eventName = events[indexPath.row].eventName
        MvC.eventDateFrom = events[indexPath.row].eventFromDate
        MvC.eventID = events[indexPath.row].randomID
        MvC.eventToDate = events[indexPath.row].eventToDate
//        MvC.selectionEvent = events[indexPath.row].selectionEvent
//        MvC.selectionTime = events[indexPath.row].selectionTime
//        MvC.selectionName = events[indexPath.row].selectionName
//        MvC.selectionNumber = events[indexPath.row].selectionNumber
        
        self.navigationController?.showDetailViewController(MvC, sender: nil)
    }
    
}
