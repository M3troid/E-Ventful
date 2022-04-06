//
//  SignUpViewController.swift
//  E-Ventful
//
//  Created by Drake Neuenschwander on 1/16/22.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import Firebase


class SignUpViewController: UIViewController {
    
    //variables for the singup view
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //function to respond to the sign in button tapped
    @IBAction func SignUpTapped(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        
        //validates the text fields have data.
        if email.text?.isEmpty == true {
            print("No text in email field")
            return
        }
        if password.text?.isEmpty == true {
            print("No text in password field")
            return
        }
        // connects the user to the home view and saves their email and name to the database.
        Service.signUpUser(email: email.text!, password: password.text!, name: nameField.text!, onSuccess:  {
            defaults.set(true, forKey: "isUserSignedIn")
            self.performSegue(withIdentifier: "userSignedUpSegue", sender: nil)
        }) { (error) in
            self.present(Service.createAlertController(title: "Error", message: error!.localizedDescription), animated: true, completion: nil)
        }
    }
    
    //Moves user to the sign in view
     @IBAction func alreadyHaveAccountLoginTapped(_ sender: Any) {
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let vc = storyboard.instantiateViewController(withIdentifier: "login")
         vc.modalPresentationStyle = .overFullScreen
         present(vc, animated: true)
}
    
    
}
