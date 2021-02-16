//
//  UserDetailwindowViewController.swift
//  IOS_Final_Project
//
//  Created by user168953 on 3/28/20.
//  Copyright © 2020 user168953. All rights reserved.
//

import UIKit

class UserDetailwindowViewController: UIViewController {
    
    var uCar: Car?
    
   
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.uCar != nil
        {
            //dump(uColorLabel)
            dump(uCar)
            nameLabel.text = uCar?.getItemName()
            detailLabel.text = uCar?.getItemDescription()
            priceLabel.text = "\(uCar!.getPrice())"
        }
    }
    
    
}

