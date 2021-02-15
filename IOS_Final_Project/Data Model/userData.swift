
import Foundation
class userData {


var id: Int?
var name: String?
var password: String?
var email: String?
var phone: Int?
var address: String?
var r_Id:Int?


    init(id: Int?,name: String?,password: String?,email: String?,phone: Int?,address: String?,r_Id:Int?){

    self.id = id
    self.name = name
    self.password = password
    self.email = email
    self.phone = phone
    self.address = address
    self.r_Id = r_Id
 

  }
    convenience init(dictionary: [String : Any]) {
         let id = dictionary["id"] as? Int ?? 0
         let name = dictionary["name"] as? String ?? ""
         let password = dictionary["password"] as? String ?? ""
         let email = dictionary["email"] as? String ?? ""
        let phone = dictionary["phone"] as? Int ?? 0
         let address =  dictionary["address"] as? String ?? ""
         let r_Id =  dictionary["r_Id"] as? Int ?? 0

        self.init(id: id, name: name, password: password, email: email,phone: phone, address: address, r_Id: r_Id)
     }
 }
