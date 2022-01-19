//
//  HomeViewController.swift
//  E-Ventful
//
//  Created by Drake Neuenschwander on 1/19/22.
//

import UIKit
import Firebase
import FirebaseCore


class HomeViewController: UIViewController {

    @IBOutlet weak var circleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //List of User Events.
        
        
        
        
        //Circle Button for event creation.
        
        circleButton.layer.cornerRadius = circleButton.frame.width / 2
        circleButton.layer.masksToBounds = true
        circleButton.titleLabel?.adjustsFontSizeToFitWidth = true
        circleButton.titleLabel?.minimumScaleFactor = 0.5
    }
    
}
    


