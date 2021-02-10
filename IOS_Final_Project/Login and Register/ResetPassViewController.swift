

import UIKit
import Firebase
import Toast_Swift

class ResetPassViewController: UIViewController {

    @IBOutlet weak var resetEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func sndbtn(_ sender: Any) {
        var Error : String?
        Auth.auth().sendPasswordReset(withEmail: resetEmail.text!) { (error) in
            if let error = error as NSError? {
            switch AuthErrorCode(rawValue: error.code) {
            case .userNotFound:
                 Error = " The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section."
                break
            case .invalidEmail:
                Error = " The email address is badly formatted."
                break
               
            case .invalidRecipientEmail:
                 Error = "Indicates an invalid recipient email was sent in the request."
                break
              
            case .invalidSender:
                Error = "Indicates an invalid sender email is set in the console for this action."
                break
              
            case .invalidMessagePayload:
                 Error = "Indicates an invalid email template for sending update email."
                break
              
            default:
              print("Error message: \(error.localizedDescription)")
            }
                self.view.makeToast(Error)
          } else {
             Error = "Reset password email has been successfully sent"
            self.view.makeToast(Error)
          }
        }
              

    }

}
