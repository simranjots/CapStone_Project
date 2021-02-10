
import UIKit
import Firebase
import FirebaseFirestore
import Toast_Swift

class RegisterViewController: UIViewController {

    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var Phone: UITextField!
    @IBOutlet weak var Address: UITextField!
    @IBOutlet weak var RgtBtn: UIButton!
    
     
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    @IBAction func Rgtbtn(_ sender: Any) {
        let n = name.text
        let p = Phone.text
        let a = Address.text
        let signUpManager = FirebaseAuthManager()
    
            if let email = Email.text, let password = Password.text {
                signUpManager.createUser(email: email, password: password) {[weak self] (success,message) in
                    guard let `self` = self else { return }
                    
                    if (success) {
                        
                        let db = Firestore.firestore()
                        let datas = ["Id":p,
                            "Name": n,
                            "Email":email,
                            "Password":password,
                            "Phone":p,
                            "Address":a]
                        db.collection("Users").document(p!).setData(datas as [String : Any])
                           
                        self.view.makeToast(message)
                    } else {
                        self.view.makeToast(message)
                    }
                    
                   
                
                }
                
            }
    }
   
}
