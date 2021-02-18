
import UIKit
import Firebase
import CoreData
import Foundation
import FirebaseFirestore
import Toast_Swift

class AddEditDelete: UIViewController {
    
   
    
    @IBOutlet weak var mName: UITextField!
    
    @IBOutlet weak var mDescription: UITextField!
    
    @IBOutlet weak var mPrice: UITextField!
    
    var id : String = ""
    var name : String = ""
    var detail : String = ""
    var price : Float = 0
    var edit : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if edit == "edit" {
            mName.text = name
            mDescription.text = detail
            mPrice.text = ("\(price)")
        }else{
            mName.text = ""
            mDescription.text = ""
            mPrice.text = ""
        }
        
    }
    
    
    
    
    
    @IBAction func addBtnPressed(_ sender: UIButton) {
        if edit == "edit" {
            EditData(Id: id)
        }else{
            AddData()
        }

    }
    
    
    
    
    
    
    
    
    func AddData() -> Void {
        let id = UUID().uuidString
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
                            let datas = ["id": id,
                                         "name": self.name,
                                         "imageLink": "",
                                         "description": self.detail,
                                         "price": self.price,
                                         "fav": false
                            ] as [String : Any]
                            db.collection("Menu").document("DECFA19E-D418-4C95-A24B-F6D1F846D898")
                                .collection("Khanna Khazana").document(id).setData(datas)
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
                                         "imageLink": "",
                                         "description": self.detail,
                                         "price": self.price
                            ] as [String : Any]
                            db.collection("Menu").document("DECFA19E-D418-4C95-A24B-F6D1F846D898")
                                .collection("Khanna Khazana").document("\(Id)").setData(datas)
                            }
                            
                        }
    }
                
            
    }
    
    
