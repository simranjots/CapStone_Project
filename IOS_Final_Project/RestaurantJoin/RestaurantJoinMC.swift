

import Foundation

class RestaurentJoinMC {
    var id : String?
    var name : String?
    var imageLink : String?
    var Description : String?
    
    init(id : String?, name : String? , imageLink : String?, Description : String?){
        self.id = id
        self.name = name
        self.imageLink = imageLink
        self.Description = Description
    }
    
    convenience init(dictionary: [String : Any]) {
          let id = dictionary["id"] as? String ?? ""
          let name = dictionary["name"] as? String ?? ""
          let imageLink = dictionary["imageLink"] as? String ?? ""
          let Description = dictionary["Description"] as? String ?? ""
        

        self.init(id: id, name: name, imageLink: imageLink, Description: Description)
      }

}
