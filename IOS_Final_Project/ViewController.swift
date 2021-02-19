
import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleLabel2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = ""
        var charIndex = 0.0
        let titletext = "Home Food"
        
        for letters in titletext {
            print("-")
            print(0.1 * charIndex)
            print(letters)
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false){ (Timer) in
                self.titleLabel.text?.append(letters)
            }
            charIndex += 1
        }
        
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func userButtonPressed(_ sender: UIButton) {
        
        if UserDefaults.standard.bool(forKey: "usersignedin") {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "menu") as UIViewController
            self.present(vc, animated: true, completion: nil)
        }else {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "uLogin") as UIViewController
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func managerButtonPressed(_ sender: UIButton) {
        
        if UserDefaults.standard.bool(forKey: "adminsignedin") {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "adMenu") as UIViewController
            self.present(vc, animated: true, completion: nil)
        }else {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "alogin") as UIViewController
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    

    
    
    
}

