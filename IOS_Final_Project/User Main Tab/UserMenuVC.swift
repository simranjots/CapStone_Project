//
//  UserMenuVC.swift
//  IOS_Final_Project
//
//  Created by Kuldeep on 2021-02-07.
//  Copyright © 2021 user168953. All rights reserved.
//

import UIKit
import CoreData
import SideMenu
import Firebase

class UserMenuVC: UIViewController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var UmenuTBV: UITableView!
    var uContext: NSManagedObjectContext?
    var uSelectedCar: Car?
    var menu: SideMenuNavigationController?
    var uCars = [Car]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let app_delegate = UIApplication.shared.delegate as! AppDelegate
        self.uContext = app_delegate.persistentContainer.viewContext
        self.navigationItem.setHidesBackButton(true, animated: false)
        loadCars()
        
        menu = SideMenuNavigationController(rootViewController: SettingListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.uCars.count    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UmenuTBV.dequeueReusableCell(withIdentifier: "Cell" ,for:indexPath) as! uMenuTBCell

        
        cell.dishLabel.text = self.uCars[indexPath.row].getItemName()
        return cell
    }
    internal func loadCars()
     {
         //Creating a Request
         let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FoodMenuEntity")
         
         //Creating a local variable
         var results: [NSManagedObject] = []
         
         do {
             //Fetching all the rows into results
             results = try self.uContext!.fetch(fetchRequest)
         }
         catch {
             print(error)
         }
         
         //Looping for each result
         for result in results
         {
             //Getting all the car details
             let item_name = "\(result.value(forKey: "item_name") as! NSString)"
             let price: Float = (result.value(forKey: "price") as! NSNumber).floatValue
             let item_description = "\(result.value(forKey: "item_description") as! NSString)"
             let car = Car(item_name: item_name, price: price, item_description: item_description)
             dump(car)
             self.uCars.append(car)
         }
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.uSelectedCar = self.uCars[indexPath.row]
        performSegue(withIdentifier: "itemDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "itemDetails"
        {
            if let udwvc = segue.destination as? UserDetailwindowViewController
            {
                udwvc.uCar = self.uSelectedCar
            }
        }
    }

    @IBAction func logoutbtn(_ sender: Any) {
        do {
          try Auth.auth().signOut()
        } catch {
          print("Sign out error")
        }
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "uLogin") as UIViewController
        self.present(vc, animated: true, completion: nil)

    }
    @IBAction func didTapSettting(_ sender: Any) {
        present(menu!, animated: true)

    }
    
     class SettingListController: UITableViewController{
         
         var items = ["Edit Information", "Order History", "Contact Us"]
         let lightColor = UIColor.white
         
         override func viewDidLoad() {
             super.viewDidLoad()
             tableView.backgroundColor = lightColor
             tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
         }
         
         override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
             return items.count
         }
         
         override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
             cell.textLabel?.text = items[indexPath.row]
             cell.textLabel?.textColor = UIColor(red: 250/255.0, green: 10/255.0, blue: 10/255.0, alpha: 1)
             cell.backgroundColor = lightColor
             return cell
         }
         
         override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
             return 70
         }
         
     }
}
