
import UIKit
import CoreData
import Toast_Swift

class UserLoginViewController: UIViewController {
    
    var userSetup = [userData]()
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
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
                    let fetchUD = FirebaseFD()
                    // Do any additional setup after loading the view.
//                        fetchUD.FetchTUserData(email: email) { (users) in
//                        self.userSetup = users
//                        }
                       UserDefaults.standard.setValue(email, forKey: "email")
                        UserDefaults.standard.set(true, forKey: "usersignedin")
                        UserDefaults.standard.synchronize()
                        self.view.makeToast(message)
                        
                        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "restJoinPage") as UIViewController
                        self.present(vc, animated: true, completion: nil)
                    
                    
                } else {
                    self.view.makeToast(message)
                }
                
            }
           
    
        }
    }
    
    
}
