//
//  AddnewItem.swift
//  IOS_Final_Project
//
//  Created by user168953 on 4/1/20.
//  Copyright © 2020 user168953. All rights reserved.
//

import UIKit
import CoreData

class AddnewItem: UIViewController, UITextFieldDelegate {
    
   
    
    @IBOutlet weak var mName: UITextField!
    
    @IBOutlet weak var mDescription: UITextField!
    
    @IBOutlet weak var mPrice: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    
    
    @IBAction func addBtnPressed(_ sender: UIButton) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newData = NSEntityDescription.insertNewObject(forEntityName: "FoodMenuEntity", into: context)
        
        
        newData.setValue(mName.text, forKey: "item_name")
        newData.setValue(mDescription.text, forKey: "item_description")
        newData.setValue(Int(mPrice.text!), forKey: "price")
        
        
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
