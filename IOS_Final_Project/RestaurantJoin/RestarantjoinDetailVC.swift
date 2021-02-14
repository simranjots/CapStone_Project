//
//  RestarantjoinDetailVC.swift
//  IOS_Final_Project
//
//  Created by Kuldeep on 2021-02-12.
//  Copyright © 2021 user168953. All rights reserved.
//

import UIKit
import Braintree

class RestarantjoinDetailVC: UIViewController{

    @IBOutlet weak var rstDetail_IV: UIImageView!
    @IBOutlet weak var rstDetTV: UITableView!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet var payButton: UIButton!
    
    let maxHeaderHeight: CGFloat = 320
    
    let minHeaderHeight: CGFloat = 0

    /// The last known scroll position
    var previousScrollOffset: CGFloat = 0

    /// The last known height of the scroll view content
    var previousScrollViewHeight: CGFloat = 0
    
    
    
    var braintreeClient: BTAPIClient?
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       navigationController?.navigationBar.prefersLargeTitles = true

        self.rstDetTV.delegate = self
        self.rstDetTV.dataSource = self
        
       
        
        // Start with an initial value for the content size
        self.previousScrollViewHeight = self.rstDetTV.contentSize.height
        
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           self.imageHeightConstraint.constant = self.maxHeaderHeight
     
       }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
   
    
    
    

    @IBAction func goBack(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "restJoinPage") as UIViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func PaymentButton(_ sender: Any) {
        // Process Payment once the pay button is clicked.
        braintreeClient = BTAPIClient(authorization: "sandbox_bnh653wd_rm9zxv57v66g8nzg")!
        let payPalDriver = BTPayPalDriver(apiClient: braintreeClient!)
                payPalDriver.viewControllerPresentingDelegate = self
                payPalDriver.appSwitchDelegate = self // Optional
        
        // Specify the transaction amount here. "2.32" is used in this example.
               let request = BTPayPalRequest(amount: "50.00")
               request.currencyCode = "CAD" // Optional; see BTPayPalRequest.h for more options

               payPalDriver.requestOneTimePayment(request) { (tokenizedPayPalAccount, error) in
                   if let tokenizedPayPalAccount = tokenizedPayPalAccount {
                       print("Got a nonce: \(tokenizedPayPalAccount.nonce)")

                       // Access additional information
                       let email = tokenizedPayPalAccount.email
                       let firstName = tokenizedPayPalAccount.firstName
                       let lastName = tokenizedPayPalAccount.lastName
                       let phone = tokenizedPayPalAccount.phone

                       // See BTPostalAddress.h for details
                       let billingAddress = tokenizedPayPalAccount.billingAddress
                       let shippingAddress = tokenizedPayPalAccount.shippingAddress
                    
                    self.view.makeToast("Payment made Successfully by \(firstName)")
                    self.payButton.setTitle("Joined", for: .normal)
                    self.payButton.backgroundColor = .systemGreen
                    
                   } else if let error = error {
                       // Handle error here...
                    self.payButton.setTitle("Join", for: .normal)
                    self.payButton.backgroundColor = .systemRed
                   } else {
                       // Buyer canceled payment approval
                    self.payButton.setTitle("Join", for: .normal)
                    self.payButton.backgroundColor = .systemRed
                   }
               }
    }
    
    
}

extension RestarantjoinDetailVC : BTViewControllerPresentingDelegate{
    func paymentDriver(_ driver: Any, requestsPresentationOf viewController: UIViewController) {
        
    }
    
    func paymentDriver(_ driver: Any, requestsDismissalOf viewController: UIViewController) {
        
    }
    
    
}
extension RestarantjoinDetailVC : BTAppSwitchDelegate{
    func appSwitcherWillPerformAppSwitch(_ appSwitcher: Any) {
        
    }
    
    func appSwitcher(_ appSwitcher: Any, didPerformSwitchTo target: BTAppSwitchTarget) {
        
    }
    
    func appSwitcherWillProcessPaymentInfo(_ appSwitcher: Any) {
        
    }
    
    
}


extension RestarantjoinDetailVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel!.text = "Cell \(indexPath.row)"
        return cell
    }
}

extension RestarantjoinDetailVC: UITableViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
           // Always update the previous values
           defer {
               self.previousScrollViewHeight = scrollView.contentSize.height
               self.previousScrollOffset = scrollView.contentOffset.y
           }

           let heightDiff = scrollView.contentSize.height - self.previousScrollViewHeight
           let scrollDiff = (scrollView.contentOffset.y - self.previousScrollOffset)

           // If the scroll was caused by the height of the scroll view changing, we want to do nothing.
           guard heightDiff == 0 else { return }

           let absoluteTop: CGFloat = 0;
           let absoluteBottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height;

           let isScrollingDown = scrollDiff > 0 && scrollView.contentOffset.y > absoluteTop
           let isScrollingUp = scrollDiff < 0 && scrollView.contentOffset.y < absoluteBottom

           if canAnimateHeader(scrollView) {

               // Calculate new header height
               var newHeight = self.imageHeightConstraint.constant
               if isScrollingDown {
                   newHeight = max(self.minHeaderHeight, self.imageHeightConstraint.constant - abs(scrollDiff))
               } else if isScrollingUp {
                   newHeight = min(self.maxHeaderHeight, self.imageHeightConstraint.constant + abs(scrollDiff))
               }

               // Header needs to animate
               if newHeight != self.imageHeightConstraint.constant {
                   self.imageHeightConstraint.constant = newHeight
                   self.setScrollPosition(self.previousScrollOffset)
               }
           }
       }

       func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
           self.scrollViewDidStopScrolling()
       }

       func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
           if !decelerate {
               self.scrollViewDidStopScrolling()
           }
       }

       func scrollViewDidStopScrolling() {
           let range = self.maxHeaderHeight - self.minHeaderHeight
           let midPoint = self.minHeaderHeight + (range / 2)

           if self.imageHeightConstraint.constant > midPoint {
               self.expandHeader()
           } else {
               self.collapseHeader()
           }
       }

       func canAnimateHeader(_ scrollView: UIScrollView) -> Bool {
           // Calculate the size of the scrollView when header is collapsed
           let scrollViewMaxHeight = scrollView.frame.height + self.imageHeightConstraint.constant - minHeaderHeight

           // Make sure that when header is collapsed, there is still room to scroll
           return scrollView.contentSize.height > scrollViewMaxHeight
       }

       func collapseHeader() {
           self.view.layoutIfNeeded()
           UIView.animate(withDuration: 0.2, animations: {
               self.imageHeightConstraint.constant = self.minHeaderHeight
               self.view.layoutIfNeeded()
           })
       }

       func expandHeader() {
           self.view.layoutIfNeeded()
           UIView.animate(withDuration: 0.2, animations: {
               self.imageHeightConstraint.constant = self.maxHeaderHeight
               self.view.layoutIfNeeded()
           })
       }

       func setScrollPosition(_ position: CGFloat) {
           self.rstDetTV.contentOffset = CGPoint(x: self.rstDetTV.contentOffset.x, y: position)
       }

     
   
}
