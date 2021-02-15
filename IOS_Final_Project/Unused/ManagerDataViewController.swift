//
//  ManagerDataViewController.swift
//  IOS_Final_Project
//
//  Created by user168953 on 3/28/20.
//  Copyright © 2020 user168953. All rights reserved.
//

import UIKit
import CoreData
import SideMenu

class ManagerDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let mCellIdentifier = "Cell"
    var mCars = [Car]()
    @IBOutlet weak var mTableView: UITableView!
    var mContext: NSManagedObjectContext?
    var mSelectedCar: Car?
    var menu: SideMenuNavigationController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let app_delegate = UIApplication.shared.delegate as! AppDelegate
        self.mContext = app_delegate.persistentContainer.viewContext
        self.navigationItem.setHidesBackButton(true, animated: false)
        loadCars()
        
        menu = SideMenuNavigationController(rootViewController: SettingListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    
    
    @IBAction func logoutbtnPressed(_ sender: Any) {
        print("Done")
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addbtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "addDetails", sender: self)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mCars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: self.mCellIdentifier)
        
        if cell == nil
        {
            cell = UITableViewCell(style: .default, reuseIdentifier: self.mCellIdentifier)
        }
        
        cell?.textLabel?.text = self.mCars[indexPath.row].getItemName()
        return cell!
    }
    
    internal func loadCars()
    {
        //Creating a Request
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FoodMenuEntity")
        
        //Creating a local variable
        var results: [NSManagedObject] = []
        
        do {
            //Fetching all the rows into results
            results = try self.mContext!.fetch(fetchRequest)
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
            self.mCars.append(car)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.mCars = [Car]()
        loadCars()
        self.mTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.mSelectedCar = self.mCars[indexPath.row]
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails"
        {
            if let mdvc = segue.destination as? ManagerDetailViewController
            {
                mdvc.mCar = self.mSelectedCar
            }
        }
    }
    @IBAction func didTappedSettings(_ sender: Any) {
        //present(menu!, animated: true)
        performSegue(withIdentifier: "toEdit", sender: self)
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
        
        override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
            switch indexPath.row {
            case 0:
//                performSegue(withIdentifier: "FirstMenuViewController", sender: self)
//                let firstMenuVC = self.storyboard?.instantiateViewController(withIdentifier: "FirstMenuViewController") as! EditInformationViewController
//                self.navigationController?.pushViewController(firstMenuVC, animated: true)
                
//                let secondVC =  storyboard?.instantiateViewController(withIdentifier: "FirstMenuViewController") as! EditInformationViewController
//                self.present(secondVC, animated:true, completion:nil)
                //performSegue(withIdentifier: "toEdit", sender: self)
                performSegue(withIdentifier: "toEdit", sender: self)
            case 1:
//            let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! OrderHistoryViewController
//            self.navigationController?.pushViewController(secondVC, animated: true)
                self.performSegue(withIdentifier: "toEdit", sender: self)
            case 2:
//            let thirdVC = self.storyboard?.instantiateViewController(withIdentifier: "ThirdViewController") as! ContactUsViewController
//            self.navigationController?.pushViewController(thirdVC, animated: true)
                
                self.performSegue(withIdentifier: "toEdit", sender: self)
            default:
                break
            }
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
    }
}
