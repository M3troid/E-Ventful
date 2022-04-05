//
//  LoginViewController.swift
//  E-Ventful
//
//  Created by Drake Neuenschwander on 1/16/22.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signinTapped(_ sender: Any) {
        validateFileds()
        let auth = Auth.auth()
        let defaults = UserDefaults.standard
        
        auth.signIn(withEmail: email.text!, password: password.text!) { (authResult, error) in
            if error != nil {
                self.present(Service.createAlertController(title: "Error", message: error!.localizedDescription), animated: true, completion: nil)
                return
                
            }
            
            defaults.set(true, forKey: "isUserSignedIn")
            self.performSegue(withIdentifier: "userSignedInSegue", sender: nil)
        }
        
    }
    
    @IBAction func createAccountTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "signUp")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    func validateFileds() {
        if email.text?.isEmpty == true {
            print("No email text")
            return
        }
        if password.text?.isEmpty == true {
            print("No password text")
            return
        }
        
    }

}