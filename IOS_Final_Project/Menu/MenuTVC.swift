

import UIKit
import Firebase
import Toast_Swift


class MenuTVC: UIViewController {



    var menuSetup = [MenuMC]()
    
    @IBOutlet weak var menuTB: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchProducts { (products) in
                    self.menuSetup = products
                    self.menuTB.reloadData()
                }
    }

  

}
func fetchProducts(_ completion: @escaping ([MenuMC]) -> Void) {
    let ref = Firestore.firestore().collection("Menu").document("1").collection("menu")
ref.addSnapshotListener { (snapshot, error) in
    guard error == nil, let snapshot = snapshot, !snapshot.isEmpty else {
        return
        
    }

    completion(snapshot.documents.compactMap( {MenuMC(dictionary: $0.data())} ))
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
