

import UIKit
import Firebase
import Toast_Swift
import FirebaseFirestore


class ADMenuTVC: UIViewController {


    var rowSelected : Int = 0
    var menuSetup = [MenuMC]()
    var id : String = ""
    
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
    App

  
    @IBAction func addData(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "addData") as! AddEditDelete
        self.present(vc, animated: true, completion: nil)
    }
    
}


extension ADMenuTVC: UITableViewDelegate, UITableViewDataSource {

func numberOfSections(in tableView: UITableView) -> Int {
    return 1
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return menuSetup.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "amenuListCell") as?
            ADMenuTVCell else { return UITableViewCell() }

    cell.configure(withProduct: menuSetup[indexPath.row])

    return cell
}
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let db = Firestore.firestore()
        id = menuSetup[self.rowSelected].id!
        if editingStyle == .delete {
            menuSetup.remove(at: indexPath.row)
            menuTB.deleteRows(at: [indexPath], with: .fade)
            db.collection("Menu").document("DECFA19E-D418-4C95-A24B-F6D1F846D898")
                .collection("Khanna Khazana").document(id).delete()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowSelected = indexPath.row
                print(rowSelected)
        performSegue(withIdentifier: "edit", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let destVC = segue.destination as? AddEditDelete {
            destVC.edit = "edit"
            destVC.id = menuSetup[self.rowSelected].id!
            destVC.name = menuSetup[self.rowSelected].name!
            destVC.detail = menuSetup[self.rowSelected].description!
            destVC.price = menuSetup[self.rowSelected].price!
                }
           
    }

}
