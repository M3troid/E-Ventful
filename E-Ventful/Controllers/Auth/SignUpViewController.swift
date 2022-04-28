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


class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    //variables for the singup view
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phone.addTarget(self, action: #selector(SignUpViewController.phoneFieldDidChange(_:)), for: .editingDidEnd)
        nameField.addTarget(self, action: #selector(SignUpViewController.nameFieldDidChange(_:)), for: .editingDidEnd)
        email.addTarget(self, action: #selector(SignUpViewController.emailFieldDidChange(_:)), for: .editingDidEnd)
        password.addTarget(self, action: #selector(SignUpViewController.passwordFieldDidChange(_:)), for: .editingDidEnd)
        
        phone.delegate = self
        
        
        // Do any additional setup after loading the view.
    }
    func userSignedUp() {
        let defaults = UserDefaults.standard
        
        //validates the text fields have data.
        if password.text!.isEmpty {
            password.layer.borderColor = UIColor.red.cgColor
            password.layer.borderWidth = 1.0
        }
        if email.text!.isEmpty {
            email.layer.borderColor = UIColor.red.cgColor
            email.layer.borderWidth = 1.0
        }
        if phone.text!.isEmpty {
            phone.layer.borderColor = UIColor.red.cgColor
            phone.layer.borderWidth = 1.0
        }
        if nameField.text!.isEmpty {
            nameField.layer.borderColor = UIColor.red.cgColor
            nameField.layer.borderWidth = 1.0
        }
        // connects the user to the home view and saves their email and name to the database.
        UserAuthService.signUpUser(email: email.text!, password: password.text!, name: nameField.text!, phone: phone.text!, onSuccess:  {
            defaults.set(true, forKey: "isUserSignedIn")
            self.performSegue(withIdentifier: "userSignedUpSegue", sender: nil)
        }) { (error) in
            self.present(UserAuthService.createAlertController(title: "Error", message: error!.localizedDescription), animated: true, completion: nil)
        }
        
    
    }
    
    @objc func emailFieldDidChange(_ textField: UITextField) {
        if (email.text!.isEmpty)
            {
                email.layer.borderColor = UIColor.red.cgColor
                email.layer.borderWidth = 1.0
            }
            else
            {
                email.layer.borderWidth = 0
                email.layer.borderColor = UIColor.clear.cgColor
            }
        }
    @objc func passwordFieldDidChange(_ textField: UITextField) {
        if (password.text!.isEmpty)
            {
                password.layer.borderColor = UIColor.red.cgColor
                password.layer.borderWidth = 1.0
            }
            else
            {
                password.layer.borderWidth = 0
                password.layer.borderColor = UIColor.clear.cgColor
            }
        }
    @objc func phoneFieldDidChange(_ textField: UITextField) {
        if (phone.text!.isEmpty)
            {
                phone.layer.borderColor = UIColor.red.cgColor
                phone.layer.borderWidth = 1.0
            }
            else
            {
                phone.layer.borderWidth = 0
                phone.layer.borderColor = UIColor.clear.cgColor
            }
        }
    @objc func nameFieldDidChange(_ textField: UITextField) {
        if (nameField.text!.isEmpty)
            {
                nameField.layer.borderColor = UIColor.red.cgColor
                nameField.layer.borderWidth = 1.0
            }
            else
            {
                nameField.layer.borderWidth = 0
                nameField.layer.borderColor = UIColor.clear.cgColor
            }
        }
    //function to respond to the sign in button tapped
    @IBAction func SignUpTapped(_ sender: Any) {
        if nameField.text!.isEmpty || password.text!.isEmpty || email.text!.isEmpty || phone.text!.isEmpty {
            
            let dialogMessage = UIAlertController(title: "Action Required", message: "One or more items need more information.", preferredStyle: .alert)
            
            // Create OK button with action handler
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
             })
            
            //Add OK button to a dialog message
            dialogMessage.addAction(ok)
            // Present Alert to
            self.present(dialogMessage, animated: true, completion: nil)
        } else {
            userSignedUp()
        }
        }
}
 
    func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator

        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])

                // move numbers iterator to the next index
                index = numbers.index(after: index)

            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
    


extension SignUpViewController: UITableViewDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = format(with: "(XXX)-XXX-XXXX", phone: newString)
        return false
    }
}
