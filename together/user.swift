//
//  user.swift
//  together
//
//  Created by ooo on 29/07/2017.
//  Copyright © 2017 Seven Tsai. All rights reserved.
//

import Foundation
import Firebase

struct User1 {
    
    let uid:String
    let email:String
    
    init(authData: User){
        
        self.uid = authData.uid
        self.email = authData.email!
        
    }
}
