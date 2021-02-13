//
//  ViewController.swift
//  IOS_Final_Project
//
//  Created by user168953 on 3/27/20.
//  Copyright © 2020 user168953. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleLabel2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationController?.setNavigationBarHidden(true, animated: false)
        
        titleLabel.text = ""
        var charIndex = 0.0
        let titletext = "Home Food"
        
        for letters in titletext {
            print("-")
            print(0.1 * charIndex)
            print(letters)
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false){ (Timer) in
                self.titleLabel.text?.append(letters)
            }
            charIndex += 1
        }
        
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func userButtonPressed(_ sender: UIButton) {
        
       
        
    }
    
    
    @IBAction func managerButtonPressed(_ sender: UIButton) {
        
        
        
    }
    
//    func createData() {
//
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//
//        let managedContext = appDelegate.persistentContainer.viewContext
//
//        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
//
//        for i in 1...5 {
//
//            let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
//            user.setValue("Ankur\(i)", forKeyPath: "username")
//            user.setValue("ankur\(i)@test.com", forKey: "email")
//            user.setValue("ankur\(i)", forKey: "password")
//        }
//
//        do {
//            try managedContext.save()
//
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//        }
//
//
//    }
//
    
    
    
    
}

