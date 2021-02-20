

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage

class FirebaseFD {
    
    var userUrl : URL?
    func fetchProducts(_ completion: @escaping ([MenuMC]) -> Void) {
        let ref = Firestore.firestore().collection("Menu").document("DECFA19E-D418-4C95-A24B-F6D1F846D898").collection("Khanna Khazana")
         ref.addSnapshotListener { (snapshot, error) in
        guard error == nil, let snapshot = snapshot, !snapshot.isEmpty else {
            return
            
        }

        completion(snapshot.documents.compactMap( {MenuMC(dictionary: $0.data())} ))
    }
    }
    
    
    
    func FetchTodays(_ completion: @escaping ([MenuMC]) -> Void) {
      
        let ref = Firestore.firestore().collection("Menu").document("DECFA19E-D418-4C95-A24B-F6D1F846D898").collection("Khanna Khazana").whereField("fav", isEqualTo: true)
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
    
    
    
    func fetchRestaurants(_ completion: @escaping ([RestaurentJoinMC]) -> Void) {
        let ref = Firestore.firestore().collection("Restaurants")
        ref.addSnapshotListener { (snapshot, error) in
        guard error == nil, let snapshot = snapshot, !snapshot.isEmpty else {
            return
            
        }

        completion(snapshot.documents.compactMap( {RestaurentJoinMC(dictionary: $0.data())} ))
    }
    }
    
    
    func uploading( img : UIImageView,id : String, completion: @escaping ((String) -> Void)) {
        var strURL = ""
        let storageRef = Storage.storage().reference()
        let storeImage = storageRef.child("images/\(id)")

        if let uploadImageData = (img.image)!.pngData(){
            storeImage.putData(uploadImageData, metadata: nil, completion: { (metaData, error) in
                storeImage.downloadURL(completion: { (url, error) in
                    if let urlText = url?.absoluteString {

                        strURL = urlText
                        print("///////////tttttttt//////// \(strURL)   ////////")

                        completion(strURL)
                    }
                })
            })
        }
    }
      
}
