//
//  MasterViewController.swift
//  RealtyAppPrototype
//
//  Created by Jake Johnson on 6/16/18.
//  Copyright © 2018 Jake Johnson. All rights reserved.
//

import UIKit
import Firebase

class PropertyListTableViewController: UITableViewController {

  // MARK: Constants
  let listToUsers = "ListToUsers"
    
    let propertyPicturesArray : [UIImage] = [UIImage(named: "property1")!,UIImage(named: "property2")!,UIImage(named: "property3")!,UIImage(named: "property4")!,UIImage(named: "property5")!]

  
  // MARK: Properties
  var items: [PropertyItem] = []
  var user: User!
  var userCountBarButtonItem: UIBarButtonItem!
  let ref = Database.database().reference(withPath: "properties")
  let usersRef = Database.database().reference(withPath: "online")
    

  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  // MARK: UIViewController Lifecycle  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    tableView.allowsMultipleSelectionDuringEditing = false
    
    userCountBarButtonItem = UIBarButtonItem(title: "1",
                                             style: .plain,
                                             target: self,
                                             action: #selector(userCountButtonDidTouch))
    userCountBarButtonItem.tintColor = UIColor.white
    navigationItem.leftBarButtonItem = userCountBarButtonItem
    
    ref.queryOrdered(byChild: "completed").observe(.value, with: { snapshot in
      var newItems: [PropertyItem] = []
      for child in snapshot.children {
        if let snapshot = child as? DataSnapshot,
          let propertyItem = PropertyItem(snapshot: snapshot) {
          newItems.append(propertyItem)
        }
      }
      
      self.items = newItems
      self.tableView.reloadData()
    })
    
    Auth.auth().addStateDidChangeListener { auth, user in
      guard let user = user else { return }
      self.user = User(authData: user)
      
      let currentUserRef = self.usersRef.child(self.user.uid)
      currentUserRef.setValue(self.user.email)
      currentUserRef.onDisconnectRemoveValue()
    }
    
    usersRef.observe(.value, with: { snapshot in
      if snapshot.exists() {
        self.userCountBarButtonItem?.title = snapshot.childrenCount.description
      } else {
        self.userCountBarButtonItem?.title = "0"
      }
    })
    
    ref.observe(.value, with: { snapshot in
        print(snapshot.value as Any)
            })
  }
  
  // MARK: UITableView Delegate methods
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
    
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 200.0;//Choose your custom row height
    }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
    let propertyItem = items[indexPath.row]
    
    cell.textLabel?.text = propertyItem.name
    cell.detailTextLabel?.text = propertyItem.location
    
    cell.backgroundView = UIImageView.init(image: UIImage(named: propertyItem.imagename)) 
//    cell.imageView?.image = UIImage(named: propertyItem.imagename)
    
    toggleCellCheckbox(cell, isCompleted: propertyItem.completed)
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let propertyItem = items[indexPath.row]
      propertyItem.ref?.removeValue()
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) else { return }
    let propertyItem = items[indexPath.row]
    let toggledCompletion = !propertyItem.completed
    toggleCellCheckbox(cell, isCompleted: toggledCompletion)
    propertyItem.ref?.updateChildValues([
      "completed": toggledCompletion
      ])
  }
  
  func toggleCellCheckbox(_ cell: UITableViewCell, isCompleted: Bool) {
    if !isCompleted {
      cell.accessoryType = .none
      cell.textLabel?.textColor = .black
      cell.detailTextLabel?.textColor = .black
    } else {
      cell.accessoryType = .checkmark
      cell.textLabel?.textColor = .gray
      cell.detailTextLabel?.textColor = .gray
    }
  }
  
//  // MARK: Add Item  
//  @IBAction func addButtonDidTouch(_ sender: AnyObject) {
//    let alert = UIAlertController(title: "Property Item",
//                                  message: "Add an Item",
//                                  preferredStyle: .alert)
//    
//    let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
//      guard let textField = alert.textFields?.first,
//        let text = textField.text else { return }
//      
//
//      let propertyItem = PropertyItem(name: text,
//                                    addedByUser: self.user.email,
//                                    completed: false)
//
//      let propertyItemRef = self.ref.child(text.lowercased())
//      
//      propertyItemRef.setValue(propertyItem.toAnyObject())
//    }
//    
//    let cancelAction = UIAlertAction(title: "Cancel",
//                                     style: .cancel)
//    
//    alert.addTextField()
//    
//    alert.addAction(saveAction)
//    alert.addAction(cancelAction)
//    
//    present(alert, animated: true, completion: nil)
//  }
  
  @objc func userCountButtonDidTouch() {
    performSegue(withIdentifier: listToUsers, sender: nil)
  }
}
