//
//  Msgviewitem.swift
//  together
//
//  Created by ooo on 29/07/2017.
//  Copyright © 2017 Seven Tsai. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct GroupReviewItem {
    var childId:String
    var groupId: String
    var groupName: String
    var groupReview: String
    var userId: String
    var userEmail: String
    var createDate: String
    
    init(snapshot: DataSnapshot) {
        print(snapshot)
         //取出snapshot的值(JSON)
        //date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/M/d H:m"
        let string = formatter.string(from: Date())
        
        let snapshotValue: [String: AnyObject] = snapshot.value as! [String: AnyObject]
        self.childId = snapshotValue["childId"] as! String
        self.groupId = snapshotValue["groupId"] as! String
        self.groupName = snapshotValue["groupName"] as! String
        self.groupReview = snapshotValue["groupReview"] as! String
        self.userId = snapshotValue["userId"] as! String
        self.userEmail = snapshotValue["userEmail"] as! String
        self.createDate = snapshotValue["createDate"] as! String
    }
    
}
