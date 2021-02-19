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

    var menuSetup = [MenuMC]()

    @IBOutlet weak var UmenuTBV: UITableView!
  
    var menu: SideMenuNavigationController?
    var userInfo : User?
    override func viewDidLoad() {
      
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        menu = SideMenuNavigationController(rootViewController: settingListVC())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)

        let fetchTodaySp = FirebaseFD()
        // Do any additional setup after loading the view.
        fetchTodaySp.FetchTodays { (products) in
                    self.menuSetup = products
                    self.UmenuTBV.reloadData()
                }
    }
    
    
    @IBAction func logoutbtn(_ sender: Any) {
       

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

    
    
    
    
    








