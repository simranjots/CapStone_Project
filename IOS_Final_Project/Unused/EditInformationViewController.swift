//
//  EditInformationViewController.swift
//  IOS_Final_Project
//
//  Created by Arpita Sharma on 25/08/20.
//  Copyright © 2020 user168953. All rights reserved.
//

import UIKit
import CoreData

class EditInformationViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addBtnPressed(_ sender: UIButton) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newData = NSEntityDescription.insertNewObject(forEntityName: "DetailsEntity", into: context)
        
        newData.setValue(name.text, forKey: "name")
        newData.setValue(address.text, forKey: "address")
        newData.setValue(city.text, forKey: "city")
        newData.setValue(zipCode.text, forKey: "zipCode")
        
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
