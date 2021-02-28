//
//  keyboard.swift
//  IOS_Final_Project
//
//  Created by Kuldeep on 2021-02-28.
//  Copyright © 2021 user168953. All rights reserved.
//

import UIKit
extension UIViewController {
    
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            // if keyboard size is not available for some reason, dont do anything
            return
         }
       
       // move the root view up by the distance of keyboard height
       self.view.frame.origin.y = 0 - keyboardSize.height
     
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
}
