

import UIKit
import Firebase
import FirebaseStorage
import SDWebImage

class ADMenuTVCell: UITableViewCell {

    @IBOutlet weak var adminImg: UIImageView!
    @IBOutlet weak var adminName: UILabel!
    @IBOutlet weak var adminPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(withProduct menuItem: MenuMC) {
           
        adminName.text = menuItem.name
        adminPrice.text = "\(menuItem.price ?? 0)"
       
        // Load the image using SDWebImage
        adminImg.sd_setImage(with: URL(string:menuItem.imageLink!), placeholderImage: UIImage(named: "image_1.png"))

//        fetchImage(withURL: menuItem.imageLink! ) { (image) in
//            self.menuImg.image = image
//         }
//      }
//
//      func fetchImage(withURL url: String, _ completion: @escaping (UIImage) -> Void) {
//       let ref = Storage.storage().reference(forURL: url)
//           ref.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
//               guard error == nil, let imageData = data, let image = UIImage(data: imageData) else {
//                   return
//               }
//               completion(image)
//           }
      }
}
