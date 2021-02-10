

import Foundation
class UserMC {
    var id : Int?
    var name : String?
    var imageLink : String?
    var description : String?
    var price : Float?
    
    init(id : Int?, name : String? , imageLink : String?, description : String?, price : Float?){
        self.id = id
        self.name = name
        self.imageLink = imageLink
        self.description = description
        self.price = price
    }
    
    convenience init(dictionary: [String : Any]) {
          let id = dictionary["id"] as? Int ?? 0
          let name = dictionary["name"] as? String ?? ""
          let imageLink = dictionary["imageLink"] as? String ?? ""
          let description = dictionary["description"] as? String ?? ""
        let price =  dictionary["price"] as? Float ?? 0.0
        

          self.init(id: id, name: name, imageLink: imageLink, description: description, price: price)
      }

}
