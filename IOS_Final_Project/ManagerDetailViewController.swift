//
//  ManagerDetailViewController.swift
//  IOS_Final_Project
//
//  Created by user168953 on 4/1/20.
//  Copyright © 2020 user168953. All rights reserved.
//

import UIKit
import CoreData

class ManagerDetailViewController: UIViewController {
    
    var mContext: NSManagedObjectContext?
    var mCar: Car?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let app_delegate = UIApplication.shared.delegate as! AppDelegate
        self.mContext = app_delegate.persistentContainer.viewContext
        
        if self.mCar != nil
        {
            nameLabel.text = mCar?.getItemName()
            priceLabel.text = "\(mCar!.getPrice())"
            detailLabel.text = mCar?.getItemDescription()
            
        }
    }
    
    @IBAction func deletebtnPressed(_ sender: Any) {
        
        removeFoodFromCoreData(price: self.priceLabel.text!, context: mContext!)
        
        self.navigationController?.popViewController(animated: true)

        
    }
    
    func removeFoodFromCoreData(price: String, context: NSManagedObjectContext)
    {
         //Creating a Request
         let fetch_request = NSFetchRequest<NSFetchRequestResult>(entityName: "FoodMenuEntity")

        //Setting the search criteria
         fetch_request.predicate = NSPredicate(format: "price = %@", price)
        do
         {
            //Fetching the data
             let test = try context.fetch(fetch_request)

            //Fetching the Car Object
           let object_to_delete = test[0] as! NSManagedObject

             //Deleting the object
            context.delete(object_to_delete)
             do
             {
                 //Saving the Database
                 try context.save()
             }
             catch
             {
                 //Prints error if encountered when saving
                 print(error)
             }
         }
         catch
         {
             //Prints error if encountered when fetching
             print(error)
         }
     }
}
