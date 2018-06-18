//
//  Property.swift
//  RealtyAppPrototype
//
//  Created by Jake Johnson on 6/16/18.
//  Copyright © 2018 Jake Johnson. All rights reserved.
//

import Foundation
import Firebase

struct PropertyItem {
    
    let ref: DatabaseReference?
    let location: String
    let name: String
    let cost: Int
    let imageurl : String
    let imagename : String
    var completed: Bool
    
    init(name: String, location: String, imagename : String, cost : Int, imageurl : String, completed: Bool) {
        self.ref = nil
        self.imageurl = imageurl
        self.name = name
        self.location = location
        self.cost = cost
        self.imagename = imagename
        self.completed = completed
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String,
            let location = value["location"] as? String,
            let cost = value["cost"] as? Int,
            let imageurl = value["image-url"] as? String,
            let imagename = value["image-name"] as? String,
            let completed = value["completed"] as? Bool else {
                return nil
        }

        self.ref = snapshot.ref
        self.location = location
        self.name = name
        self.cost = cost
        self.imageurl = imageurl
        self.imagename = imagename
        self.completed = completed
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "location": location,
            "cost": cost,
            "imageurl": imageurl,
            "imagename": imagename,
            "completed": completed
        ]
    }
}
