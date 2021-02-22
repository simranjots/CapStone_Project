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
import Foundation

class AdminMenuVC: UIViewController,UITableViewDelegate, UITableViewDataSource{

    let fetchTodaySp = FirebaseFD()
    var menuSetup = [MenuMC]()
    var userSetup = [userData]()
    var mSetup = [ManagerMC]()
    var user : String? = ""
    var rest_id :String? = ""
    var rest_n :String? = ""
    
    @IBOutlet weak var UmenuTBV: UITableView!
    var uContext: NSManagedObjectContext?
    var uSelectedCar: MenuMC?
    var menu: SideMenuNavigationController?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let app_delegate = UIApplication.shared.delegate as! AppDelegate
        self.uContext = app_delegate.persistentContainer.viewContext
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        menu = SideMenuNavigationController(rootViewController: SettingListControllers())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let em = UserDefaults.standard.string(forKey: "email")
        print("email \(String(describing: em))")
        fetchTodaySp.FetchtManrData(email: em!, completion: { (users) in
            self.mSetup = users
            for employee in self.mSetup {
                self.rest_id = employee.Id
                self.rest_n = employee.Rest_Name
                print("rest_id  :\(String(describing: self.rest_id) )")
            }
            self.fetchTodaySp.FetchtMangerData(id: self.rest_id!) { (manager) in
                self.mSetup = manager
                for employee in self.mSetup {
                    self.rest_n = employee.Rest_Name
                    print("rest_n  :\(String(describing: self.rest_n) )")
                }
            
            // Do any additional setup after loading the view.
            self.fetchTodaySp.FetchTodays(id: self.rest_id!, name: self.rest_n!) { (products) in
                        self.menuSetup = products
                self.UmenuTBV.reloadData()
            }
            }
        })
    }
    

    @IBAction func didTapSettting(_ sender: Any) {
        present(menu!, animated: true)

    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if menuSetup.count == 0 {
            return 0
        }
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return menuSetup.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "adminCell", for: indexPath) as! AdminMenuTBCell
       
      
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


    
    
    
    
    class SettingListControllers: UITableViewController{
        
        var items = ["Profile Update", "Order History", "Restaurants List" , "Logout", "Contact Us", ]
        let lightColor = UIColor.lightGray
        
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
            cell.textLabel?.textColor = .systemYellow
            cell.backgroundColor = lightColor
            return cell
        }
        
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 70
        }
       
        override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            
            let view = UIView()
            view.backgroundColor = .systemYellow
            let  image = UIImageView.init(frame: CGRect(x: 5,y: 5,width: 35,height: 35))
            image.sd_setImage(with: URL(string:"imageUrl"), placeholderImage: UIImage(named: "homefoods"))
            view.addSubview(image)
            
            let label = UILabel()
            label.textColor = .darkGray
            label.text = "HomeFood"
            label.frame = CGRect(x: 45, y: 5, width: 100, height: 35)
            view.addSubview(label)
            
            
            return view
        }
        override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 45
        }
        override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
          override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
              switch indexPath.row {
              case 0:
                  let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                  let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "ThirdViewController") as UIViewController
                  self.present(vc, animated: true, completion: nil)
                  break

              case 1:
                

                  break
              case 2:
                  let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                  let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "restJoinPage") as UIViewController
                  self.present(vc, animated: true, completion: nil)

                  break
              case 3:
                  
                  do {
                  try Auth.auth().signOut()
                      print("logout")
                      UserDefaults.standard.set(false, forKey: "adminsignedin")
                      UserDefaults.standard.synchronize()
                      let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                      let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "login") as UIViewController
                      self.present(vc, animated: true, completion: nil)
                  } catch let signOutError as NSError {
                      print ("Error signing out: %@", signOutError)
                      
                  }
                  break
              case 4:
                  let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                  let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "ThirdViewController") as UIViewController
                  self.present(vc, animated: true, completion: nil)
                  break
                  
              default:
               
                  break
              }
          }
    }









