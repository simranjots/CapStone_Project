
import UIKit
import Firebase
import FirebaseFirestore
import Toast_Swift
import iOSDropDown

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var Phone: UITextField!
    @IBOutlet weak var Address: UITextField!
    @IBOutlet weak var RgtBtn: UIButton!
    @IBOutlet weak var RstOwner: DropDown!
    let userId = UUID().uuidString
    var imgUrl : String = ""
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // The list of array to display. Can be changed dynamically
        RstOwner.optionArray = ["Yes", "No"]
        RstOwner.selectedRowColor = .secondarySystemBackground
        // Do any additional setup after loading the view.
        // create tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.imageTapped(gesture:)))

        // add it to the image view;
        UserImage.addGestureRecognizer(tapGesture)
        // make sure imageView can be interacted with by user
        UserImage.isUserInteractionEnabled = true

           }
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if (gesture.view as? UIImageView) != nil {
            print("Image Tapped")
            //Here you can initiate your new ViewController
            let vc = UIImagePickerController()
            vc.allowsEditing = true
            vc.delegate = self
            present(vc, animated: true)
        }
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
            vc.id = userId
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
                        let datas = ["Id":self.userId,
                            "name": n,
                            "email":email,
                            "imageLink":"\(self.imgUrl)",
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        UserImage.image = UIImage(named: "star")
        // print out the image size as a test
        let imageupoad =  FirebaseFD()
        let img = self.UserImage
        let str = imageupoad.uploading(img: img!,id :self.userId) { (url) in
             print(url)
            self.imgUrl = url
            self.UserImage.image = image
         }
      
        print(image.size)
    }
   
}
