
import Foundation
class ManagerMC {


var Id: String?
var Name: String?
var Password: String?
var Email: String?
var Phone: String?
var Address: String?
var Rest_Name:String?
var Rest_ownr:String?
var Rest_Loc :String?
var Rest_NumofLoc :String?


    init(id: String?,name: String?,password: String?,email: String?,phone: String?,address: String?,Rest_ownr:String?,Rest_Loc:String?,Rest_NumofLoc:String?,Rest_Name:String?){

    self.Id = id
    self.Name = name
    self.Password = password
    self.Email = email
    self.Phone = phone
    self.Address = address
    self.Rest_Name = Rest_Name
    self.Rest_ownr = Rest_ownr
    self.Rest_Loc = Rest_Loc
    self.Rest_NumofLoc = Rest_NumofLoc

  }
    init() {
    }
    convenience init(dictionary: [String : Any]) {
         let id = dictionary["id"] as? String ?? ""
         let name = dictionary["name"] as? String ?? ""
         let password = dictionary["password"] as? String ?? ""
         let email = dictionary["email"] as? String ?? ""
         let phone = dictionary["phone"] as? String ?? ""
         let address =  dictionary["address"] as? String ?? ""
         let Rest_Name =  dictionary["Rest_Name"] as? String ?? ""
         let Rest_ownr =  dictionary["Rest_ownr"] as? String ?? ""
         let Rest_Loc =  dictionary["Rest_Loc"] as? String ?? ""
         let Rest_NumofLoc =  dictionary["Rest_NumofLoc"] as? String ?? ""


        
        self.init(id: id, name: name, password: password, email: email,phone: phone, address: address, Rest_ownr: Rest_ownr,Rest_Loc: Rest_Loc,Rest_NumofLoc: Rest_NumofLoc,Rest_Name: Rest_Name)
     }
 }
