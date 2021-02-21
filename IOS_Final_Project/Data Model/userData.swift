
import Foundation
class userData {


var id: String?
var name: String?
var password: String?
var email: String?
var imageLink : String?
var phone: String?
var address: String?
var rest_Join_Id:String?
var rest_ownr:String?
    
    init(id: String?,name: String?,password: String?,email: String?,imageLink : String?,phone: String?,address: String?,rest_Join_Id:String?,rest_ownr:String?){

    self.id = id
    self.name = name
    self.password = password
    self.email = email
    self.imageLink = imageLink
    self.phone = phone
    self.address = address
    self.rest_Join_Id = rest_Join_Id
 

  }
    convenience init(dictionary: [String : Any]) {
         let id = dictionary["id"] as? String ?? ""
         let name = dictionary["name"] as? String ?? ""
         let password = dictionary["password"] as? String ?? ""
         let email = dictionary["email"] as? String ?? ""
         let imageLink =  dictionary["imageLink"] as? String ?? ""
         let phone = dictionary["phone"] as? String ?? ""
         let address =  dictionary["address"] as? String ?? ""
         let rest_Join_Id =  dictionary["rest_Join_Id"] as? String ?? ""
        let rest_ownr =  dictionary["rest_ownr"] as? String ?? ""
        self.init(id: id, name: name, password: password, email: email,imageLink: imageLink,phone: phone, address: address, rest_Join_Id: rest_Join_Id,rest_ownr:rest_ownr)
     }
 }
