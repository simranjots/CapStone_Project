//
//  FirebaseAuthManager.swift
//  IOS_Final_Project
//
//  Created by Kuldeep on 2021-02-05.
//  Copyright © 2021 user168953. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import UIKit

class FirebaseAuthManager {

   
    
    func createUser(email: String, password: String, completionBlock: @escaping (_ success: Bool,String) -> Void) {
        var Error : String?
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let user = authResult?.user {
                Error = "User was sucessfully created."
                completionBlock(true,Error!)
            } else {
                if let error = error as NSError? {
                    switch AuthErrorCode(rawValue: error.code) {
                    case .operationNotAllowed:
                
                      Error = "The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section."
                        break
                    case .emailAlreadyInUse:
                     Error = "The email address is already in use by another account."
                        break
                    case .invalidEmail:
                        Error = "The email address is badly formatted ."
                        break
                    case .weakPassword:
                      Error = "The password must be 6 characters long or more."
                        break
                    default:
                        print("Error: \(error.localizedDescription)")
                    }
                    
                }
                completionBlock(false,Error!)
            }
        }
    }
    
    func signIn(email: String, pass: String, completionBlock: @escaping (_ success: Bool,String) -> Void) {
        var Error : String?
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if let error = error, let _ = AuthErrorCode(rawValue: error._code) {
                if let error = error as? NSError {
                  switch AuthErrorCode(rawValue: error.code) {
                  case .operationNotAllowed:
                    Error = "Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console."
                    break
                  case .userDisabled:
                   Error = "The user account has been disabled by an administrator."
                    break
                  case .wrongPassword:
                     Error = "The Email or the  password is invalid "
                    break
                  case .invalidEmail:
                     Error = "Indicates the email address is malformed."
                    break
                    
                  default:
                      print("Error: \(error.localizedDescription)")
                  }
                }
                completionBlock(false,Error ?? "Invalid email address" )
            } else {
                let userEmail = Auth.auth().currentUser?.email
               
                Error = "User Sign In sucessfully ."
               
                completionBlock(true,Error!)
            }
        }
    }
    func updatepassword(pss : String) -> Void {
        Auth.auth().currentUser?.updatePassword(to: pss, completion: { (error) in
          if let error = error as? NSError {
            switch AuthErrorCode(rawValue: error.code) {
            case .userDisabled: break
              // Error: The user account has been disabled by an administrator.
            case .weakPassword: break
              // Error: The password must be 6 characters long or more.
            case .operationNotAllowed: break
              // Error: The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.
            case .requiresRecentLogin: break
              // Error: Updating a user’s password is a security sensitive operation that requires a recent login from the user. This error indicates the user has not signed in recently enough. To resolve, reauthenticate the user by invoking reauthenticateWithCredential:completion: on FIRUser.
            default:
              print("Error message: \(error.localizedDescription)")
            }
          } else {
            print("User signs up successfully")
          }
        })
    }
    func updateEmail(email : String) -> Void {
        Auth.auth().currentUser?.updateEmail(to: email, completion: { (error) in
          if let error = error as? NSError {
            switch AuthErrorCode(rawValue: error.code) {
            case .invalidRecipientEmail:
              // Error: Indicates an invalid recipient email was sent in the request.
              print("Indicates an invalid recipient email was sent in the request.")
            case .invalidSender:
              // Error: Indicates an invalid sender email is set in the console for this action.
              print("Indicates an invalid sender email is set in the console for this action.")
            case .invalidMessagePayload:
              // Error: Indicates an invalid email template for sending update email.
              print("Indicates an invalid email template for sending update email.")
            case .emailAlreadyInUse:
              // Error: The email address is already in use by another account.
              print("Email has been already used by another user.")
            case .invalidEmail:
              // Error: The email address is badly formatted.
              print("Email is not well formatted")
            case .requiresRecentLogin:
              // Error: Updating a user’s password is a security sensitive operation that requires a recent login from the user. This error indicates the user has not signed in recently enough. To resolve, reauthenticate the user by invoking reauthenticateWithCredential:completion: on FIRUser.
              print("Updating a user’s password is a security sensitive operation that requires a recent login from the user. This error indicates the user has not signed in recently enough. To resolve, reauthenticate the user by invoking reauthenticateWithCredential:completion: on FIRUser.")
            default:
              print("Error message: \(error.localizedDescription)")
            }
          } else {
            print("Update email is successful")
          }
        })
    }
    func DeleteAccount(email: String) -> Void {
        Auth.auth().currentUser?.delete(completion: { (error) in
          if let error = error as? NSError {
            switch AuthErrorCode(rawValue: error.code) {
            case .operationNotAllowed:
              // Error: The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.
              print("Email/ Password sign in provider is new disabled")
            case .requiresRecentLogin:
              // Error: Updating a user’s password is a security sensitive operation that requires a recent login from the user. This error indicates the user has not signed in recently enough. To resolve, reauthenticate the user by invoking reauthenticateWithCredential:completion: on FIRUser.
              print("Updating a user’s password is a security sensitive operation that requires a recent login from the user. This error indicates the user has not signed in recently enough. To resolve, reauthenticate the user by invoking reauthenticateWithCredential:completion: on FIRUser.")
            default:
              print("Error message: \(error.localizedDescription)")
            }
          } else {
            print("User account is deleted successfully")
          }
        })
    }
    
    
}
