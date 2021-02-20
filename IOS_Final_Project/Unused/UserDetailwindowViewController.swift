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
    
   
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var name :String = ""
    var price :Float = 0
    var detail :String = ""
    var imgUrl :String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            image.sd_setImage(with: URL(string:imgUrl), placeholderImage: UIImage(named: "image_1.png"))
            nameLabel.text = name
            detailLabel.text = detail
            priceLabel.text = "\(price) $"
        
    }
    
    
}

