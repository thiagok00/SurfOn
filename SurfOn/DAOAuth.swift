//
//  DAOAuth.swift
//  
//
//  Created by Thiago De Angelis on 16/08/16.
//
//

import Foundation
import Firebase

class DAOAuth{



    class func login(email:String, password:String!,callback:@escaping (String?) ->(Void) ) {
        
        func loginCallback (user:FIRUser?, error:Error?) {
            if error != nil {
                callback("erro")
            }
            else {
                callback(nil)
            }
        }

        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: loginCallback)
    }
    

    class func register(email:String, password:String, callback:@escaping (String?) ->(Void)) {
    
        func signUpCallback (user: FIRUser?, error: Error?) {
            if error != nil {
                callback("erro")
            }
            else {
                callback(nil)
            }
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: signUpCallback)
    }
    
    
    
    
    
    
    
}
