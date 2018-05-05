//
//  User.swift
//  ChatSwapUp
//
//  Created by Bernardo Sarto de Lucena on 5/1/18.
//  Copyright © 2018 Bernardo Sarto de Lucena. All rights reserved.
//


import UIKit

class Users: NSObject {
    
    var id: String?
    var age: String?
    var city: String?
    var country: String?
    var email: String?
    var gender: String?
    var name: String?
    var profileImageUrl: String?
    
    init(dictionary: [String: Any]) {
        self.age = dictionary["age"] as? String
        self.city = dictionary["city"] as? String
        self.country = dictionary["country"] as? String
        self.email = dictionary["email"] as? String
        self.gender = dictionary["gender"] as? String
        self.name = dictionary["name"] as? String
        self.profileImageUrl = dictionary["profileImageUrl"] as? String
    }
    
}
