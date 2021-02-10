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

class UserMenuVC: UIViewController,UITableViewDelegate, UITableViewDataSource{

    var menuSetup = [UserMC]()

    @IBOutlet weak var UmenuTBV: UITableView!
    var uContext: NSManagedObjectContext?
    var uSelectedCar: UserMC?
    var menu: SideMenuNavigationController?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let app_delegate = UIApplication.shared.delegate as! AppDelegate
        self.uContext = app_delegate.persistentContainer.viewContext
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        menu = SideMenuNavigationController(rootViewController: SettingListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)

        // Do any additional setup after loading the view.
        FetchTodays { (products) in
                    self.menuSetup = products
                    self.UmenuTBV.reloadData()
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
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuSetup.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as?
                uMenuTBCell else { return UITableViewCell() }

        cell.configure(withProduct: menuSetup[indexPath.row])

        return cell
    }
 
        
//        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            self.uSelectedCar = self.menuSetup[indexPath.row]
//            performSegue(withIdentifier: "itemDetails", sender: self)
//        }
//
//        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//            return 120
//        }
//
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if segue.identifier == "itemDetails"
//            {
//                if let udwvc = segue.destination as? UserDetailwindowViewController
//                {
//                    udwvc.uCar = self.uSelectedCar
//                }
//            }
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

func FetchTodays(_ completion: @escaping ([UserMC]) -> Void) {
    let ref = Firestore.firestore().collection("Menu").document("2").collection("Todaysp")
ref.addSnapshotListener { (snapshot, error) in
    guard error == nil, let snapshot = snapshot, !snapshot.isEmpty else {
        return
        
    }

    completion(snapshot.documents.compactMap( {UserMC(dictionary: $0.data())} ))
}
    
}





