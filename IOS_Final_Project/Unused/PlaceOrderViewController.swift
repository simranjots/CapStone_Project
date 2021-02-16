//
//  PlaceOrderViewController.swift
//  IOS_Final_Project
//
//  Created by Arpita Sharma on 25/08/20.
//  Copyright © 2020 user168953. All rights reserved.
//

import UIKit
import CoreData

class PlaceOrderViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var streetAddress: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    @IBOutlet weak var quantity: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func orderBtnPressed(_ sender: UIButton) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let newData = NSEntityDescription.insertNewObject(forEntityName: "CartEntity", into: context)
            
            newData.setValue(name.text, forKey: "name")
            newData.setValue(streetAddress.text, forKey: "streetAddress")
            newData.setValue(city.text, forKey: "city")
            newData.setValue(zipCode.text, forKey: "zipCode")
            newData.setValue(Int(quantity.text!), forKey: "quantity")
            
            do{
                try context.save()
            }
            catch{
                print("I/O ERROR")
            }
            print(newData)
            print("Object Saved.")
        
            
            self.navigationController?.popViewController(animated: true)
        
    }
    

}
