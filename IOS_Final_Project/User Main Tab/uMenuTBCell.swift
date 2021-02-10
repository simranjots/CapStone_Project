//
//  uMenuTBCell.swift
//  IOS_Final_Project
//
//  Created by Kuldeep on 2021-02-07.
//  Copyright © 2021 user168953. All rights reserved.
//

import UIKit

class uMenuTBCell: UITableViewCell {

    @IBOutlet weak var dishImg: UIImageView!
    @IBOutlet weak var dishLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func configure(withProduct menuItem: UserMC) {
           
           dishLabel.text = menuItem.name
      //  menuPrice.text = "\(menuItem.price ?? 0)"
       
        // Load the image using SDWebImage
        dishImg.sd_setImage(with: URL(string:menuItem.imageLink!), placeholderImage: UIImage(named: "menu.png"))


}
}
