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
    var rowSelected : Int = 0

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
 
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.rowSelected = indexPath.row
        print(self.rowSelected)
            print(self.menuSetup[self.rowSelected].imageLink!)
        self.performSegue(withIdentifier: "itemDetails", sender: indexPath.row)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let destVC = segue.destination as? UserDetailwindowViewController {
          
            destVC.name = menuSetup[self.rowSelected].name!
            destVC.detail = menuSetup[self.rowSelected].description!
            destVC.price = menuSetup[self.rowSelected].price!
            destVC.imgUrl = menuSetup[self.rowSelected].imageLink!
                }

    }
        }

    
    
    
    
    








