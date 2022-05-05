//
//

import UIKit
import Firebase

class ForgotPassViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func forgotPassButton_Tapped(_ sender: Any) {
        let auth = Auth.auth()
        
        auth.sendPasswordReset(withEmail: emailField.text!) { (error) in
            if let error = error {
                let alert = UserAuthService.createAlertController(title: "Error", message: error.localizedDescription)
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            let alert = UserAuthService.createAlertController(title: "Password Reset", message: "A password reset email has been sent!")
            self.present(alert, animated: true, completion: nil)
        }
    }

}
