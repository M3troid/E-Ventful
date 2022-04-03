//
//  HomeViewController.swift
//  E-Ventful
//
//  Created by Drake Neuenschwander on 1/19/22.
//

import UIKit
import Foundation
import Firebase
//import FirebaseAuth


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var circleButton: UIButton!
    let userID = Auth.auth().currentUser?.uid
    
    let ref = Database.database().reference(withPath: "ID1")
    var refObservers: [DatabaseHandle] = []
    
    
    var user: User?
    var handle: AuthStateDidChangeListenerHandle?
    var table: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelectionDuringEditing = false
        
        fetch()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let completed = ref
            .queryOrdered(byChild: "completed")
            .observe(.value) { snapshot in
                var newItems: [Event] = []
                for child in snapshot.children {
                    if
                        let snapshot = child as? DataSnapshot,
                        let eventItem = Event(snapshot: snapshot) {
                        newItems.append(eventItem)
                        self.ref.observe(.value, with: {snapshot in
                            print(snapshot.value as Any)
                        })
                    }
                }
                self.table = newItems
                self.tableView.reloadData()
            }
        refObservers.append(completed)
        
//        handle = Auth.auth().addStateDidChangeListener {_, user in
//            guard let user = user else { return }
//            self.user = User(authData: user)
//
//            let currentUserRef = self.userRef.child(user.uid)
//
//        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        refObservers.forEach(ref.removeObserver(withHandle:))
        refObservers = []
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return table.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let eventItem = table[indexPath.row]
        
        cell.textLabel?.text = eventItem.eventName
        
        
        return cell
    }
    func fetch() {
        Database.database().reference().child("ID1").observe(.childAdded) { (snapshot) in
            print("data")
            print(snapshot.value as Any )
            
        }
    }
}
    


