
import UIKit
import Firebase
import FirebaseFirestore
import Toast_Swift
import iOSDropDown
class RestaurantRegisterVC: UIViewController {

    @IBOutlet weak var rstName: UITextField!
    @IBOutlet weak var rstLocation: UITextField!
    @IBOutlet weak var nmbOfLoc: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

          stepper.wraps = true
          stepper.autorepeat = true
          stepper.maximumValue = 10
    }
    var id :String?
    var name : String?
    var ema : String?
    var pass : String?
    var phone : String?
    var address : String?
    var rstOwner : String?
    var rstNm : String?
    var rstLc : String?
    var rstNum : String?
    
    
    @IBAction func addLoc(_ sender: UIStepper!) {
        nmbOfLoc.text = String(Int(sender.value))    }
    
    
    @IBAction func registerRest(_ sender: Any) {
       
        rstNm = rstName.text
        rstLc = rstLocation.text
        rstNum = nmbOfLoc.text
        
        let signUpManager = FirebaseAuthManager()
    
            if let email = ema, let password = pass {
                signUpManager.createUser(email: email, password: password) {[weak self] (success,message) in
                    guard let `self` = self else { return }
                    
                    if (success) {
                        
                        let db = Firestore.firestore()
                        let datas = ["Id":self.id,
                                     "Name": self.name,
                                     "Email":self.ema,
                                     "Password":self.pass,
                                     "Phone":self.phone,
                                     "Address":self.address,
                                     "Rest_ownr":self.rstOwner,
                                     "Rest_Name":self.rstNm,
                                     "Rest_Loc":self.rstLc,
                                     "Rest_NumofLoc":self.rstNum]
                        db.collection("Owners").document(self.phone!).setData(datas as [String : Any])
                           
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
    
}
