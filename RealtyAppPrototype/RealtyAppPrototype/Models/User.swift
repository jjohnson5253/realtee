//
//  User.swift
//  RealtyAppPrototype
//
//  Created by Jake Johnson on 6/16/18.
//  Copyright © 2018 Jake Johnson. All rights reserved.
//

import Foundation
//import Firebase

struct User {
    
    let uid: String
    let email: String
    
//    init(authData: Firebase.User) {
//        uid = authData.uid
//        email = authData.email!
//    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
}
