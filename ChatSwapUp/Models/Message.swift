//
//  Message.swift
//  ChatSwapUp
//
//  Created by Bernardo Sarto de Lucena on 5/1/18.
//  Copyright © 2018 Bernardo Sarto de Lucena. All rights reserved.
//

import UIKit
import Firebase

class Message: NSObject {
    
    var fromId: String?
    var text: String?
    var timestamp: NSNumber?
    var toId: String?
    
    var imageUrl: String?
    var imageHeight: NSNumber?
    var imageWidth: NSNumber?
    
    var videoUrl: String?
    
    func chatPartnerId() -> String? {
        return fromId == Auth.auth().currentUser?.uid ? toId : fromId
    }
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        
        fromId = dictionary["fromId"] as? String
        text = dictionary["text"] as? String
        timestamp = dictionary["timestamp"] as? NSNumber
        toId = dictionary["toId"] as? String
        
        imageUrl = dictionary["imageUrl"] as? String
        imageHeight = dictionary["imageHeight"] as? NSNumber
        imageWidth = dictionary["imageWidth"] as? NSNumber
        
        videoUrl = dictionary["videoUrl"] as? String
        
    }
}










//import UIKit
//
//class Message: NSObject {
//
//    var fromId: String?
//    var text: String?
//    var timeStamp: NSNumber?
//    var toId: String?
//
//}
