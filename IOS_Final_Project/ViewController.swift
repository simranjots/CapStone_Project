
import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleLabel2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationController?.setNavigationBarHidden(true, animated: false)
        
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
        
       
        
    }
    
    
    @IBAction func managerButtonPressed(_ sender: UIButton) {
        
        
        
    }
    

    
    
    
}

