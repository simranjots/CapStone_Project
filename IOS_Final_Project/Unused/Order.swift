//
//  Order.swift
//  IOS_Final_Project
//
//  Created by Arpita Sharma on 25/08/20.
//  Copyright © 2020 user168953. All rights reserved.
//

import Foundation

class order
{

    var name: String
    var streetAddress: String
    var city: String
    var zipCode: String
    var quantity: Float
    
    init(name: String, streetAddress: String, city: String, zipCode: String, quantity: Float) {
        self.name = name
        self.streetAddress = streetAddress
        self.city = city
        self.zipCode = zipCode
        self.quantity = quantity
    }
    
    func getName() -> String
    {
        return self.name
    }
    
    func getStreetAddress() -> String
    {
        return self.streetAddress
    }
    
    func getCity() -> String
    {
        return self.city
    }
    
    func getZipCode() -> String
    {
        return self.zipCode
    }
    
    func getQuantity() -> Float
    {
        return self.quantity
    }
    
}
