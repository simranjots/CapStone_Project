

import UIKit
import Firebase
import Toast_Swift


class MenuTVC: UIViewController {



    var menuSetup = [MenuMC]()
    
    @IBOutlet weak var menuTB: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let dataFetch = FirebaseFD()
        // Do any additional setup after loading the view.
        dataFetch.fetchProducts { (products) in
                    self.menuSetup = products
                    self.menuTB.reloadData()
                }
    }

  

}


extension MenuTVC: UITableViewDelegate, UITableViewDataSource {

func numberOfSections(in tableView: UITableView) -> Int {
    return 1
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return menuSetup.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuListCell") as?
        MenuTVCell else { return UITableViewCell() }

    cell.configure(withProduct: menuSetup[indexPath.row])

    return cell
}

}
