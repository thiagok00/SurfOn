//
//  User.swift
//  SurfOn
//
//  Created by Thiago De Angelis on 13/10/16.
//
//

import Foundation
import Firebase

class User {
    
    var uid:String
    var email:String
    
    var name:String?
    var lastName:String?
    var categories:[Int]?
    var favoriteBeaches:[Int]?
    
    
    init (uid:String, email:String) {
        self.uid = uid
        self.email = email
    }
    
    init (user:FIRUser) {
        self.uid = user.uid
        if let email = user.providerData.first?.email {
            self.email = email
        }
        else {
            self.email = ""
        }
    }
    
    
    
}
