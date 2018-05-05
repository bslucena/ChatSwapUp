//
//  MessageControllerTableViewController.swift
//  ChatSwapUp
//
//  Created by Bernardo Sarto de Lucena on 5/5/18.
//  Copyright © 2018 Bernardo Sarto de Lucena. All rights reserved.
//

import UIKit
import Firebase

class MessageControllerTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    func nomeMassa() {
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String : AnyObject] {
                self.navigationItem.title = dictionary["name"] as? String
            }
            
            
        }, withCancel: nil)
    }

}
