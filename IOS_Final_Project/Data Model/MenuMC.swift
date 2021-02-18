//
//  MenuMC.swift
//  IOS_Final_Project
//
//  Created by Kuldeep on 2021-02-07.
//  Copyright © 2021 user168953. All rights reserved.
//

import Foundation

class MenuMC {
    var id : String?
    var name : String?
    var imageLink : String?
    var description : String?
    var price : Float?
    var fav : Bool?
    
    init(id : String?, name : String? , imageLink : String?, description : String?, price : Float?, fav : Bool?){
        self.id = id
        self.name = name
        self.imageLink = imageLink
        self.description = description
        self.price = price
        self.fav = fav
    }
    
    convenience init(dictionary: [String : Any]) {
          let id = dictionary["id"] as? String ?? ""
          let name = dictionary["name"] as? String ?? ""
          let imageLink = dictionary["imageLink"] as? String ?? ""
          let description = dictionary["description"] as? String ?? ""
          let price =  dictionary["price"] as? Float ?? 0.0
          let fav  = dictionary["fav"] as? Bool ?? false
        

        self.init(id: id, name: name, imageLink: imageLink, description: description, price: price, fav : fav)
      }

}
