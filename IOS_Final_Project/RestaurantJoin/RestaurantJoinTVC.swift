

import UIKit
import Firebase
import Toast_Swift

class RestaurantJoinTVC: UIViewController {
   
    let fetchRestData = FirebaseFD()
    var restJoin = [RestaurentJoinMC]()
    var rowSelected : Int = 0
    var rest : String = ""
    @IBOutlet weak var restJoinTv: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
     
        


}
    override func viewWillAppear(_ animated: Bool) {
        // Do any additional setup after loading the view.
        fetchRestData.fetchRestaurants { (restaurant) in
                    self.restJoin = restaurant
            if (self.rest.isEmpty){
                self.restJoinTv.reloadData()
            }else{
                if self.restJoin.isEmpty {
                    
                }else{
                    print(self.restJoin[0].name)
                    self.restJoinTv.reloadData()
                }
            }
                  
     
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.rowSelected = indexPath.row
        print(self.rowSelected)
            print(self.restJoin[self.rowSelected].imageLink!)
        self.performSegue(withIdentifier: "join", sender: indexPath.row)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let destVC = segue.destination as? RestarantjoinDetailVC {
          
            destVC.id = restJoin[self.rowSelected].id!
            
                }

    } }
            



