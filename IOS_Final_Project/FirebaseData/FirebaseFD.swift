

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage

class FirebaseFD {
    
    var userUrl : URL?
    func fetchProducts(id:String,name :String,completion: @escaping ([MenuMC]) -> Void) {
        let ref = Firestore.firestore().collection("Menu").document(id).collection(name)
         ref.addSnapshotListener { (snapshot, error) in
            if error != nil
            {
                
            }
            else {
                
                for document in snapshot!.documents {
                    print("\(document.documentID) => \(document.data() ["id"] as! String)")
                 let e = document.data() ["description"] as! String
                 let p = document.data() ["id"] as! String
                 print("hell \(e)")
                    print("hell \(e)")
                }
                completion(snapshot!.documents.compactMap( {MenuMC(dictionary: $0.data())} ))
            
                return
                
            }

                
        }
       
    }
    
    
    
    func FetchTodays(id:String,name :String,completion: @escaping ([MenuMC]) -> Void) {
        
        let ref = Firestore.firestore().collection("Menu").document(id).collection(name).whereField("fav", isEqualTo: true)
        ref.addSnapshotListener { (snapshot, error) in
        if error != nil
        {
            
        }
        else {
            completion(snapshot!.documents.compactMap( {MenuMC(dictionary: $0.data())} ))
            return
            
        }

            
    }
    }
    
    func FetchTUserData(email: String,completion: @escaping ([userData]) -> Void) {
      
        let ref = Firestore.firestore().collection("Users").whereField("email", isEqualTo: email)
        ref.addSnapshotListener { (snapshot, error) in
        if error != nil
        {
            
        }
        else {
            completion(snapshot!.documents.compactMap( {userData(dictionary: $0.data())} ))
            return
            
        }

            
    }
    }
        
  func FetchtManrData(email: String,completion: @escaping ([ManagerMC]) -> Void) {
          
            let ref = Firestore.firestore().collection("Owners").whereField("Email", isEqualTo: email)
            ref.addSnapshotListener { (snapshot, error) in
            if error != nil
            {
                
            }
            else {
                
                for document in snapshot!.documents {
                    print("\(document.documentID) => \(document.data() ["Id"] as! String)")
                 let e = document.data() ["Email"] as! String
                 let p = document.data() ["Password"] as! String
                 print("hell \(e)")
                }
                completion(snapshot!.documents.compactMap( {ManagerMC(dictionary: $0.data())} ))
                return
                
            }

                
        }
    }
    func FetchtMangerData(id: String,completion: @escaping ([ManagerMC]) -> Void) {
      
        let ref = Firestore.firestore().collection("Owners").whereField("Id", isEqualTo: id)
        ref.addSnapshotListener { (snapshot, error) in
        if error != nil
        {
            
        }
        else {
            completion(snapshot!.documents.compactMap( {ManagerMC(dictionary: $0.data())} ))
            return
            
        }

            
    }
    }
    
    
    
    
    func fetchRestaurants(_ completion: @escaping ([RestaurentJoinMC]) -> Void) {
        let ref = Firestore.firestore().collection("Restaurants")
        ref.addSnapshotListener { (snapshot, error) in
            if error != nil
            {
                
            }
            else {
                
                for document in snapshot!.documents {
                    print("\(document.documentID) => \(document.data() ["id"] as! String)")
                 let e = document.data() ["imageLink"] as! String
                 let p = document.data() ["id"] as! String
                 print("hell \(e)")
                    print("hell \(e)")
                }
                completion(snapshot!.documents.compactMap( {RestaurentJoinMC(dictionary: $0.data())} ))

                return
                
         
            }
        }
    }
    
    
    func uploading( img : UIImageView,id : String, completion: @escaping ((String) -> Void)) {
        var strURL = ""
        let storageRef = Storage.storage().reference()
        let storeImage = storageRef.child("images/\(id)")

        if let uploadImageData = (img.image)!.pngData(){
            storeImage.putData(uploadImageData, metadata: nil, completion: { (metaData, error) in
                storeImage.downloadURL { (URL, error) -> Void in
                  if (error != nil) {
                    // Handle any errors
                    print(error)
                  } else {
                    // Get the download URL for 'images/stars.jpg'

                      strURL = URL!.absoluteString
                    print(strURL)

                    completion(strURL)
                   // you will get the String of Url
                  }
                }
               
            })
        }
        
    }
    }


