
import UIKit
import Firebase
import FirebaseFirestore
import Toast_Swift
import iOSDropDown

class RegisterViewController: UIViewController {

    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var Phone: UITextField!
    @IBOutlet weak var Address: UITextField!
    @IBOutlet weak var RgtBtn: UIButton!
    @IBOutlet weak var RstOwner: DropDown!
    
    
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // The list of array to display. Can be changed dynamically
        RstOwner.optionArray = ["Yes", "No"]
        RstOwner.selectedRowColor = .secondarySystemBackground
        // Do any additional setup after loading the view.
        
           }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    @IBAction func Rgtbtn(_ sender: Any) {
        let n = name.text
        let p = Phone.text
        let a = Address.text
        // The the Closure returns Selected Index and String
        RstOwner.didSelect{(selectedText , index ,id) in
        self.RstOwner.text = "Selected String: \(selectedText) \n index: \(index)"
      }
        let rstown = RstOwner.text
        
        if n != "" && p != "" && a != "" && rstown != "" && Email.text != "" && Password.text != ""
        {
            
        if rstown == "Yes" {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "restDetails") as! RestaurantRegisterVC
            vc.id = UUID().uuidString
            vc.name = n
            vc.phone = p
            vc.address = a
            vc.pass = Password.text
            vc.ema = Email.text
            vc.rstOwner = rstown
            self.present(vc, animated: true, completion: nil)
        }else{

        let signUpManager = FirebaseAuthManager()
    
            if let email = Email.text, let password = Password.text {
                signUpManager.createUser(email: email, password: password) {[weak self] (success,message) in
                    guard let `self` = self else { return }
                    
                    if (success) {
                        
                        let db = Firestore.firestore()
                        let datas = ["Id":UUID().uuidString,
                            "name": n,
                            "email":email,
                            "password":password,
                            "phone":p,
                            "address":a,
                            "rest_ownr":rstown,
                            "rest_Join_Id":""]
                        db.collection("Users").document(p!).setData(datas as [String : Any])
                           
                        self.view.makeToast(message)
                        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "login") as! ViewController
                        self.present(vc, animated: true, completion: nil)
                    } else {
                        self.view.makeToast(message)
                    }
                    
                   
                
                }
                
            }
    }
    } else{
        
        self.view.makeToast("Please Enter all the feilds ")
        
    }
    }
   
   
}
