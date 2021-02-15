//
//  RegisterLoginViewController.swift
//  IOS_Final_Project
//
//  Created by user168953 on 3/28/20.
//  Copyright © 2020 user168953. All rights reserved.
//

import UIKit
import CoreData

class KitchenLoginViewController: UIViewController {
    
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
     
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newManager = NSEntityDescription.insertNewObject(forEntityName: "ManagerEntity", into: context)
        
        if (username.text == "" && password.text == ""){
            let alert = UIAlertController(title: "Message", message: "Enter Username or password", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

            self.present(alert, animated: true)
            username.text = ""
            password.text = ""
        }
        else {
        newManager.setValue(username.text, forKey: "username")
        newManager.setValue(password.text, forKey: "password")
        }
        
        
        do{
             try context.save()
        }
        catch{
            print("I/O ERROR")
        }
        print(newManager)
        print("Object Saved.")
        
        
      performSegue(withIdentifier: "managerDetails", sender: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.username.text = ""
        self.password.text = ""
    }
    
}
