//
//  settingListVC.swift
//  IOS_Final_Project
//
//  Created by Kuldeep on 2021-02-19.
//  Copyright © 2021 user168953. All rights reserved.
//

import UIKit
import Firebase

class settingListVC: UITableViewController {

    
    var items = ["Profile Update", "Order History", "Restaurants List" , "Logout", "Contact Us", ]
    let lightColor = UIColor.white
    var name :String = ""
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.systemGray2
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

    }
    override func viewWillAppear(_ animated: Bool) {
        let user = UserDefaults.standard.string(forKey: "email")
         print(user as Any)
        Firestore.firestore().collection("Users").whereField("email", isEqualTo:user as Any)
            .getDocuments() { [self] (snapshot, err) in
                if let err = err {
                           print("Error getting documents: \(err)")
                       } else {
                           for document in snapshot!.documents {
                               print("\(document.documentID) => \(document.data() ["name"] as! String)")
                             name = document.data() ["name"] as! String
                            _ = document.data() ["password"] as! String
                            print("hell \(name)")
                         
                        }
                        
             }
         
     }
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
                UserDefaults.standard.set(false, forKey: "usersignedin")
                UserDefaults.standard.synchronize()
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "uLogin") as UIViewController
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

