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


class HomeViewController: UIViewController {//, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var testLabel: UILabel!
   // @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var circleButton: UIButton!

    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testLabel.text = defaults.string(forKey: "eventName")
        
        let defaults = UserDefaults.standard
        
        Service.getUserInfo(onSuccess: {
            self.testLabel.text = defaults.string(forKey: "eventName")
        }) { (error) in
            self.present(Service.createAlertController(title: "Error", message: error!.localizedDescription), animated: true, completion: nil)
        }

        
    }
    
    
    
 
        
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//    }
//
//func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    <#code#>
//}
//



    


