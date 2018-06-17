//
//  AppDelegate.swift
//  RealtyAppPrototype
//
//  Created by Jake Johnson on 6/15/18.
//  Copyright © 2018 Jake Johnson. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()

        return true
    }
}


