//
//  MenuTVCell.swift
//  IOS_Final_Project
//
//  Created by Kuldeep on 2021-02-07.
//  Copyright © 2021 user168953. All rights reserved.
//

import UIKit

class MenuTVCell: UITableViewCell {

    @IBOutlet weak var menuImg: UIImageView!
    @IBOutlet weak var menuName: UILabel!
    @IBOutlet weak var menuPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(withProduct menuItem: MenuMC) {
           
           menuName.text = menuItem.name
        menuPrice.text = "\(menuItem.price ?? 0)"

//           fetchImage(withURL: product.imageUrl ) { (image) in
//              productImage.image = image
         }
      }

//      func fetchImage(withURL url: String, _ completion: @escaping (UIImage) -> Void) {
//           let ref = Storage.storage().reference(forURL: url)
//           ref.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
//               guard error == nil, let imageData = data, let image = UIImage(data: imageData) else {
//                   return
//               }
//               completion(image)
//           }
//       }
//}
