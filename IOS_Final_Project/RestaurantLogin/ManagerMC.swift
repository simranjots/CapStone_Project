
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


    init(Id: String?,Name: String?,Password: String?,Email: String?,Phone: String?,Address: String?,Rest_ownr:String?,Rest_Loc:String?,Rest_NumofLoc:String?,Rest_Name:String?){

    self.Id = Id
    self.Name = Name
    self.Password = Password
    self.Email = Email
    self.Phone = Phone
    self.Address = Address
    self.Rest_Name = Rest_Name
    self.Rest_ownr = Rest_ownr
    self.Rest_Loc = Rest_Loc
    self.Rest_NumofLoc = Rest_NumofLoc

  }
    init() {
    }
    convenience init(dictionary: [String : Any]) {
         let Id = dictionary["Id"] as? String ?? ""
         let Name = dictionary["Name"] as? String ?? ""
         let Password = dictionary["Password"] as? String ?? ""
         let Email = dictionary["Email"] as? String ?? ""
         let Phone = dictionary["Phone"] as? String ?? ""
         let Address =  dictionary["Address"] as? String ?? ""
         let Rest_Name =  dictionary["Rest_Name"] as? String ?? ""
         let Rest_ownr =  dictionary["Rest_ownr"] as? String ?? ""
         let Rest_Loc =  dictionary["Rest_Loc"] as? String ?? ""
         let Rest_NumofLoc =  dictionary["Rest_NumofLoc"] as? String ?? ""


        
        self.init(Id: Id, Name: Name, Password: Password, Email: Email,Phone: Phone, Address: Address, Rest_ownr: Rest_ownr,Rest_Loc: Rest_Loc,Rest_NumofLoc: Rest_NumofLoc,Rest_Name: Rest_Name)
     }
 }
