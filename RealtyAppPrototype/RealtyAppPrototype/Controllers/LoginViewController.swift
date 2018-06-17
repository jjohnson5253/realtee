//
//  LoginViewController.swift
//  RealtyAppPrototype
//
//  Created by Jake Johnson on 6/16/18.
//  Copyright © 2018 Jake Johnson. All rights reserved.
//

import UIKit
import Foundation
//import Firebase

class LoginViewController: UIViewController {
    
    // MARK: Constants
    let loginToList = "LoginToList"
    let backGroundImageArray : [UIImage] = [UIImage(named: "carousel1")!, UIImage(named: "carousel2")!, UIImage(named: "carousel3")!]
    
    // MARK: Variables
    var backGroundImageArrayIndex : Int = 0
    var timer: Timer!
    
    // MARK: Outlets
    @IBOutlet weak var textFieldLoginEmail: UITextField!
    @IBOutlet weak var textFieldLoginPassword: UITextField!
    @IBOutlet weak var backGround: UIImageView!
    
    
    override func viewDidLoad() {
        
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.changeCarousel), userInfo: nil, repeats: true)

//        backGround.animationImages = backGroundImageArray
//        backGround.animationDuration = 3
//        backGround.ani
//        backGround.startAnimating()
        

        
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
//        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.changeCarousel), userInfo: nil, repeats: true)

    }
    
    @objc func changeCarousel(){
        
        print("counted")
        
        // reset backgroundimagearrayindex to 0 if greater than 2, otherwise increment
        if self.backGroundImageArrayIndex == 2{
            self.backGroundImageArrayIndex = 0
        }
        else{
            self.backGroundImageArrayIndex = self.backGroundImageArrayIndex + 1
        }
        
        UIView.transition(with: self.backGround, duration:1, options: .transitionCrossDissolve,
                          animations: {
                            
                            // change to new background image
                            self.backGround.image = self.backGroundImageArray[self.backGroundImageArrayIndex]
                            
        }, completion: { (finished: Bool) -> () in
            
            
        })
        
    
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func loginDidTouch(_ sender: AnyObject) {
        performSegue(withIdentifier: loginToList, sender: nil)
    }

    @IBAction func signUpDidTouch(_ sender: AnyObject) {
        
                let alert = UIAlertController(title: "Register",
                                              message: "Register",
                                              preferredStyle: .alert)
        
                let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
                }
        
                let cancelAction = UIAlertAction(title: "Cancel",
                                                 style: .cancel)
        
                alert.addTextField { textEmail in
                    textEmail.placeholder = "Enter your email"
                }
        
                alert.addTextField { textPassword in
                    textPassword.isSecureTextEntry = true
                    textPassword.placeholder = "Enter your password"
                }
        
                alert.addAction(saveAction)
                alert.addAction(cancelAction)
        
                present(alert, animated: true, completion: nil)
    }
    
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldLoginEmail {
            textFieldLoginPassword.becomeFirstResponder()
        }
        if textField == textFieldLoginPassword {
            textField.resignFirstResponder()
        }
        return true
    }
}
