
import UIKit
import CoreData
import Toast_Swift
import Firebase


class ManagerLoginVC: UIViewController {

    var MangerL = [ManagerMC]()
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var id : String = ""
    var name : String = ""
    var pass : String = ""
    var emai : String = ""
    var phone : String = ""
    var address : String = ""
    var Rest_ownr : String = ""
    var Rest_Loc : String = ""
    var Rest_NumofLoc : String = ""
    var Rest_Name : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }
    
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        
        if (username.text == "" || password.text == ""){
            let message =  "Enter Username or password"
            self.view.makeToast(message)
        }
        else {

            let  email : String
           email = username.text!
            print(email)
            Firestore.firestore().collection("Owners").whereField("Email", isEqualTo:email)
                .getDocuments() { [self] (snapshot, err) in
                    if let err = err {
                               print("Error getting documents: \(err)")
                           } else {
                               for document in snapshot!.documents {
                                   print("\(document.documentID) => \(document.data() ["Name"] as! String)")
                                let e = document.data() ["Email"] as! String
                                let p = document.data() ["Password"] as! String
                                print("hell \(e)")
                             
                                if  (e == username.text && p == password.text ){
                                    UserDefaults.standard.setValue(e, forKey: "email")
                                    UserDefaults.standard.set(true, forKey: "adminsignedin")
                                    UserDefaults.standard.synchronize()
                                    self.view.makeToast("Successful")
                                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                    let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "adMenu") as UIViewController
                                    self.present(vc, animated: true, completion: nil)
                                   
                                }
                                else {
                                    self.view.makeToast("Login Error Please check your Email or Password is incorrect ")
   
                           }
                    
                   }
            
        }
                  
                }
    }
                
//       func fetchData() -> (Void) {
//        //let array = ManagerMC()
//        let  email : String
//       email = username.text!
//        print(email)
//        Firestore.firestore().collection("Owners").whereField("Email", isEqualTo:email as Any)
//            .getDocuments() { [self] (snapshot, err) in
//                if let err = err {
//                           print("Error getting documents: \(err)")
//                       } else {
//                           for document in snapshot!.documents {
//                               print("\(document.documentID) => \(document.data() ["Name"] as! String)")
//                            self.id =  document.data() ["Id"] as! String
//                            self.name = document.data() ["Name"] as! String
//                            self.pass = document.data() ["Password"] as! String
//                            self.emai = document.data() ["Email"] as!  String
//                            self.phone = document.data() ["Phone"] as! String
//                            self.address = document.data() ["Address"] as!  String
//                            self.Rest_ownr = document.data() ["Rest_ownr"] as!  String
//                            self.Rest_Loc = document.data() ["Rest_Loc"] as!  String
//                            self.Rest_NumofLoc = document.data() ["Rest_NumofLoc"] as!  String
//                            self.Rest_Name = document.data() ["Rest_Name"] as!  String
//
//                           self.MangerL.append(ManagerMC(id: id, name: name, password: pass, email: email, phone: phone, address: address, Rest_ownr: self.Rest_ownr, Rest_Loc: Rest_Loc, Rest_NumofLoc: Rest_NumofLoc, Rest_Name: Rest_Name))
//                        }
//                       }
//
//               }
    
    }
    
           


}
