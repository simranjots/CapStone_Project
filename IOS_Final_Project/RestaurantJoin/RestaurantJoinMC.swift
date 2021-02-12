

import Foundation

class RestaurentJoinMC {
    var id : Int?
    var name : String?
    var imageLink : String?
    var description : String?
    
    init(id : Int?, name : String? , imageLink : String?, description : String?){
        self.id = id
        self.name = name
        self.imageLink = imageLink
        self.description = description
    }
    
    convenience init(dictionary: [String : Any]) {
          let id = dictionary["id"] as? Int ?? 0
          let name = dictionary["name"] as? String ?? ""
          let imageLink = dictionary["imageLink"] as? String ?? ""
          let description = dictionary["description"] as? String ?? ""
        

          self.init(id: id, name: name, imageLink: imageLink, description: description)
      }

}
