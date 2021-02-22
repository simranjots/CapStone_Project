

import UIKit
import Firebase
import Toast_Swift
import FirebaseFirestore


class ADMenuTVC: UIViewController {

    var selectedArray : [IndexPath] = [IndexPath]()
    var rowSelected : Int = 0
    var menuSetup = [MenuMC]()
    var id : String = ""
    var ids : String = ""
    let db = Firestore.firestore()
    let fetchTodaySp = FirebaseFD()
    var userSetup = [userData]()
    var mSetup = [ManagerMC]()
    var user : String? = ""
    var rest_id :String = ""
    var rest_n :String = ""
    
    @IBOutlet weak var menuTB: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let em = UserDefaults.standard.string(forKey: "email")
        print("email \(em)")
        fetchTodaySp.FetchtManrData(email: em!, completion: { (users) in
            self.mSetup = users
            for employee in self.mSetup {
                self.rest_id = employee.Id!
                self.rest_n = employee.Rest_Name!
                print("rest_id  :\(self.rest_id )")
            }
            // Do any additional setup after loading the view.
            self.fetchTodaySp.fetchProducts(id: self.rest_id, name: self.rest_n) { (products) in
                        self.menuSetup = products
                self.menuTB.reloadData()
            }
            
        })
    }
  
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
    if(menuSetup[indexPath.row].fav!)
           {
         cell.favImg.image = UIImage(named: "starfill")
           }
           else
           {
            cell.favImg.image = UIImage(named: "star")
           }

    return cell
}
    
   
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
           UISwipeActionsConfiguration(actions:
              [makeArchiveContextualAction(forRowAt: indexPath),
               makeDeleteContextualAction(forRowAt: indexPath)])
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            rowSelected = indexPath.row
        let myCell = tableView.cellForRow(at: indexPath) as! ADMenuTVCell
            myCell.favImg.image = UIImage(named: "starfill")
            tableView.deselectRow(at: indexPath, animated: true)
          
            ids = menuSetup[rowSelected].id!
       
        let ref = Firestore.firestore().collection("Menu").document(rest_id).collection(rest_n).document(ids)

            if(!menuSetup[rowSelected].fav!)
            {
                
               ref.updateData(["fav" : true])
                    
            }
            else
            {
               ref.updateData(["fav" : false])
            }
    }
    
    func makeArchiveContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal,
                                       title: "Edit")
                                       { (contextualAction: UIContextualAction, swipeButton: UIView, completionHandler: (Bool) -> Void) in
        self.rowSelected = indexPath.row
        print(self.rowSelected)
            print(self.menuSetup[self.rowSelected].imageLink!)
        self.performSegue(withIdentifier: "edit", sender: indexPath.row)
        }
          action.backgroundColor = .systemBlue
          return action
       }
       
       func makeDeleteContextualAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
          UIContextualAction(style: .destructive,
              title: "Delete") { (contextualAction: UIContextualAction, swipeButton: UIView, completionHandler: (Bool) -> Void) in
            
            
            self.id = self.menuSetup[indexPath.row].id!

            self.db.collection("Menu").document(self.rest_id)
                .collection(self.rest_n).document(self.id).delete()
            
            self.menuSetup.remove(at: indexPath.row)
            
            self.menuTB.deleteRows(at: [indexPath], with: .fade)
             

              completionHandler(true)
           }
       }
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let destVC = segue.destination as? AddEditDelete {
            destVC.edit = "edit"
            destVC.id = menuSetup[self.rowSelected].id!
            destVC.name = menuSetup[self.rowSelected].name!
            destVC.detail = menuSetup[self.rowSelected].description!
            destVC.price = menuSetup[self.rowSelected].price!
            destVC.imgUrl = menuSetup[self.rowSelected].imageLink!
                }

    }

}
