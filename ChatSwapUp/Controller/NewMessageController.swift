//
//  NewMessageController.swift
//  ChatSwapUp
//
//  Created by Bernardo Sarto de Lucena on 5/5/18.
//  Copyright © 2018 Bernardo Sarto de Lucena. All rights reserved.
//

import UIKit

class NewMessageController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var user: Users? {
            didSet {
                navigationItem.title = user?.name
            }
        }
        
    }
    
    

}
