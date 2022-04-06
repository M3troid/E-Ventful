//
//  HomeViewController.swift
//  E-Ventful
//
//  Created by Drake Neuenschwander on 1/19/22.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var refEvents: DatabaseReference!

    @IBOutlet weak var tableViewEvents: UITableView!
    @IBOutlet weak var circleButton: UIButton!

    //list to store all the artist
    var eventList = [EventModel]()
       
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return eventList.count
       }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
            //creating a cell using the custom class
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell1
            
            //the artist object
            let event: EventModel
            
            //getting the artist of selected position
            event = eventList[indexPath.row]
            
            //adding values to labels
            cell.eventNameHomeTxt.text = event.eventName
            cell.eventDateFromHomeTxt.text = event.eventFromDate
            
            //returning cell
            return cell
        }
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirebaseApp.configure()
                
        refEvents = Database.database().reference().child("Events");

    

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
    

//   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//       return posts.count
//   }
//
//   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//       let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//
//       let label1 = cell.viewWithTag(1) as! UILabel
//       label1.text = posts[indexPath.row].eventName
//
//       let label2 = cell.viewWithTag(2) as! UILabel
//       label2.text = posts[indexPath.row].eventFromDate
//
//       return cell
//   }
//
//}
