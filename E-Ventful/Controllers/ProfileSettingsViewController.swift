//
//  ProfileSettingsViewController.swift
//  E-Ventful
//
//  Created by Drake Neuenschwander on 4/26/22.
//

import UIKit
import Firebase
import FirebaseAuth


class ProfileSettingsViewController: UIViewController {

    let userID = Auth.auth().currentUser?.uid
    
    
    @IBOutlet weak var profileNameTxt: UITextField!
    @IBOutlet weak var profileEmailTxt: UITextField!
    @IBOutlet weak var profilePhoneTxt: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let defaults = UserDefaults.standard
        
        
        
        UserAuthService.getUserInfo(onSuccess: {self.profileNameTxt.text = defaults.string(forKey: "userNameKey")
            
        }) { (error) in
            self.present(UserAuthService.createAlertController(title: "Error", message: error!.localizedDescription), animated: true, completion:nil)
        }
        
        UserAuthService.getUserInfo(onSuccess: {self.profileEmailTxt.text = defaults.string(forKey: "userEmailKey")
            
        }) { (error) in
            self.present(UserAuthService.createAlertController(title: "Error", message: error!.localizedDescription), animated: true, completion: nil)
        }
        
        UserAuthService.getUserInfo(onSuccess: {self.profilePhoneTxt.text = defaults.string(forKey: "userPhoneKey")
            
        }) { (error) in
            self.present(UserAuthService.createAlertController(title: "Error", message: error!.localizedDescription), animated: true, completion: nil)
        }
    }
    
    @IBAction func userProfileUpdate(_ sender: Any) {
        
        SaveInfo()
    }
    
    func SaveInfo() {
        
    
        UserAuthService.updateUser(profileEmailTxt: profileEmailTxt.text!, onSuccess:  {
        }) { (error) in
            self.present(UserAuthService.createAlertController(title: "Error", message: error!.localizedDescription), animated: true, completion: nil)
        }
        
        let email = profileEmailTxt.text!
        DatabaseService.shared.userRef.child("users").child(userID!).child("email").setValue(email)
        let phone = profilePhoneTxt.text!
        DatabaseService.shared.userRef.child("users").child(userID!).child("phone").setValue(phone)
        let name = profileNameTxt.text!
        DatabaseService.shared.userRef.child("users").child(userID!).child("name").setValue(name)
    }
    }
    


