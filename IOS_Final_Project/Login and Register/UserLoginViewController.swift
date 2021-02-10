
import UIKit
import CoreData
import Toast_Swift

class UserLoginViewController: UIViewController {
    
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        
        let loginManager = FirebaseAuthManager()
        if (username.text == "" || password.text == ""){
            let message =  "Enter Username or password"
            self.view.makeToast(message)
        }
        else {
            guard let email = username.text, let password = password.text else { return }
            loginManager.signIn(email: email, pass: password) {[weak self] (success,message) in
                guard let `self` = self else { return }
                
                if (success) {
                    self.view.makeToast(message)
                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "menu") as UIViewController
                    self.present(vc, animated: true, completion: nil)
                } else {
                    self.view.makeToast(message)
                }
                
            }
           
    
        }
    }
    
}
