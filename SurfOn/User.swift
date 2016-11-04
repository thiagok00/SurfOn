//
//  User.swift
//  SurfOn
//
//  Created by Thiago De Angelis on 13/10/16.
//
//

import Foundation
import Firebase
import UIKit
import FirebaseAuth

class User {
    
    var uid:String
    var email:String
    
    var name:String?
    var lastName:String?
    var profileImage:UIImage?
    var country:Country?
    var categories:[Category]!
    var favoriteBeaches:[Int]?
    
    
    init (uid:String, email:String) {
        self.uid = uid
        self.email = email
        self.categories = [Category]()
    }
    
    init (firebaseUser:FIRUser) {
        self.uid = firebaseUser.uid
        if let email = firebaseUser.providerData.first?.email {
            self.email = email
        }
        else {
            self.email = ""
        }
        self.categories = [Category]()
    }
    
    
    
}
