

import Foundation
import Firebase
import FirebaseFirestore

class FirebaseFD {
    
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
        let ref = Firestore.firestore().collection("Menu").document("DECFA19E-D418-4C95-A24B-F6D1F846D898").collection("Khanna Khazana")
        ref.addSnapshotListener { (snapshot, error) in
        guard error == nil, let snapshot = snapshot, !snapshot.isEmpty else {
            return
            
        }

        completion(snapshot.documents.compactMap( {MenuMC(dictionary: $0.data())} ))
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
    
}
