//
//  RestaurantJoinTVC.swift
//  IOS_Final_Project
//
//  Created by Kuldeep on 2021-02-12.
//  Copyright © 2021 user168953. All rights reserved.
//

import UIKit
import Firebase
import Toast_Swift

class RestaurantJoinTVC: UIViewController {
    
    var restJoin = [RestaurentJoinMC]()
    
    @IBOutlet weak var restJoinTv: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let fetchRestData = FirebaseFD()
        // Do any additional setup after loading the view.
        fetchRestData.fetchRestaurants { (restaurant) in
                    self.restJoin = restaurant
                    self.restJoinTv.reloadData()
     
    }


}
    
    @IBAction func goBackTOMenu(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "menu") as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
}
   


extension RestaurantJoinTVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restJoin.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "restJoin") as?
            RestaurantjoinTC else { return UITableViewCell() }

        cell.configure(withProduct: restJoin[indexPath.row])

        return cell
    }

    }
