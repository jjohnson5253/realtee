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
        
//        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.changeCarousel), userInfo: nil, repeats: true)

//        backGround.animationImages = backGroundImageArray
//        backGround.animationDuration = 3
//        backGround.ani
//        backGround.startAnimating()
        
        UIView.transition(with: self.backGround,
                          duration:1,
                          options: .transitionCrossDissolve,
                          animations: { self.backGround.image = self.backGroundImageArray[self.backGroundImageArrayIndex] },
                          completion: nil)
        
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
//        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.changeCarousel), userInfo: nil, repeats: true)

    }
    
    @objc func changeCarousel(){
        
        print("counted")
        
        if backGroundImageArrayIndex > 2 {backGroundImageArrayIndex = 0}
//
//        UIView.animate(withDuration: 0.3, animations: {
//            self.backGround.image = self.backGroundImageArray[self.backGroundImageArrayIndex]
//        })
        
        UIView.transition(with: self.backGround,
                          duration:1,
                          options: .transitionCrossDissolve,
                          animations: { self.backGround.image = self.backGroundImageArray[self.backGroundImageArrayIndex] },
                          completion: nil)
        
//        UIView.transition(with: imageView,
//                          duration: 0.75,
//                          options: .transitionCrossDissolve,
//                          animations: { self.imageView.image = toImage },
//                          completion: nil)

        
        backGroundImageArrayIndex = backGroundImageArrayIndex + 1
    
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
