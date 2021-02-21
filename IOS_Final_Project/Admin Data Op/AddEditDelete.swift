import UIKit
import Firebase
import CoreData
import Foundation
import FirebaseFirestore
import Toast_Swift

class AddEditDelete: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
   
    @IBOutlet weak var mImage: UIImageView!
    
    @IBOutlet weak var mName: UITextField!
    
    @IBOutlet weak var mDescription: UITextField!
    
    @IBOutlet weak var mPrice: UITextField!
    
    var id : String = ""
    var name : String = ""
    var detail : String = ""
    var price : Float = 0
    var edit : String = ""
    var imgUrl : String = ""
    let dishId = UUID().uuidString

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddEditDelete.imageTapped(gesture:)))

        // add it to the image view;
        mImage.addGestureRecognizer(tapGesture)
        // make sure imageView can be interacted with by user
        mImage.isUserInteractionEnabled = true
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if edit == "edit" {
            mName.text = name
            mDescription.text = detail
            mPrice.text = ("\(price)")
            mImage.sd_setImage(with: URL(string:imgUrl), placeholderImage: UIImage(named: "image_1.png"))
        }else{
            mName.text = ""
            mDescription.text = ""
            mPrice.text = ""
        }
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
    
    
    
    
    @IBAction func addBtnPressed(_ sender: UIButton) {
        if edit == "edit" {
            let imageupoad =  FirebaseFD()
            let img = self.mImage
            let str = imageupoad.uploading(img: img!,id :self.dishId) { (url) in
                 print(url)
                if url != nil{
                    self.imgUrl = url
                    self.EditData(Id: self.id)
                    
                    self.view.makeToast("Image Uploaded")
    
                }else
                {
                    self.view.makeToast("Please wait Image Uploading")
                }
                
             }
          
          
         
        }else{
            
            let imageupoad =  FirebaseFD()
            let img = self.mImage
            let str = imageupoad.uploading(img: img!,id :self.dishId) { (url) in
                 print(url)
                if url != nil{
                    self.imgUrl = url
                    self.AddData()
                    
                    self.view.makeToast("Image Uploaded")
    
                }else
                {
                    self.view.makeToast("Please wait Image Uploading")
                }
                
             }
            
        }
      
    }
    
    
    
    
    
    
    
    
    func AddData() -> Void {
        let db = Firestore.firestore()
            name = mName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            detail = mDescription.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            price = (mPrice.text!.trimmingCharacters(in: .whitespacesAndNewlines) as NSString).floatValue
                db.collection("Menu").document("DECFA19E-D418-4C95-A24B-F6D1F846D898")
                    .collection("Khanna Khazana")
                     .getDocuments { (snap, err) in
                        if let err = err {
                            //error
                            print(err)
                        }else {
 
                            print(snap!.documents.count)
                            self.view.makeToast("\(snap!.documents.count)")
                            let datas = ["id": self.dishId,
                                         "name": self.name,
                                         "imageLink": self.imgUrl,
                                         "description": self.detail,
                                         "price": self.price,
                                         "fav": false
                            ] as [String : Any]
                            db.collection("Menu").document("DECFA19E-D418-4C95-A24B-F6D1F846D898")
                                .collection("Khanna Khazana").document(self.dishId).setData(datas)
                            self.dismiss(animated: true, completion: nil)
                        }
                        }
    }
    
    func EditData(Id : String) -> Void {
        let db = Firestore.firestore()
            name = mName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            detail = mDescription.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            price = (mPrice.text!.trimmingCharacters(in: .whitespacesAndNewlines) as NSString).floatValue
            
                db.collection("Menu").document("DECFA19E-D418-4C95-A24B-F6D1F846D898")
                    .collection("Khanna Khazana")
                     .getDocuments { (snap, err) in
                        if let err = err {
                            //error
                            print(err)
                        }else{
                            //add data
                            let datas = ["id": Id,
                                         "name": self.name,
                                         "imageLink": self.imgUrl,
                                         "description": self.detail,
                                         "price": self.price
                            ] as [String : Any]
                            db.collection("Menu").document("DECFA19E-D418-4C95-A24B-F6D1F846D898")
                                .collection("Khanna Khazana").document("\(Id)").setData(datas)
                            self.dismiss(animated: true, completion: nil)
                            }
                            
                        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        mImage.image = image
        // print out the image size as a test
        print(image.size)
    }
                
            
    }
