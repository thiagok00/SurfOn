//
//  DAOAuth.swift
//  
//
//  Created by Thiago De Angelis on 16/08/16.
//
//

import Foundation
import Firebase
import FirebaseDatabase

class DAOAuth{

    static var user:User?

    class func login(email:String, password:String!,callback:@escaping (String?) ->(Void) ) {
        
        func loginCallback (user:FIRUser?, error:Error?) {
            if error != nil {
                callback("erro")
            }
            else {
                func retrieveCallback(error:Error?){
                    callback(error?.localizedDescription)
                }
                DAOAuth.user = User(user: user!)
                DAOAuth.retrieveUserInfo(callback: retrieveCallback)
            }
        }

        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: loginCallback)
        
    }
    

    class func register(email:String, password:String, callback:@escaping (String?) ->(Void)) {
    
        func signUpCallback (user: FIRUser?, error:Error?) {
            if error != nil {
                callback("erro")
            }
            else {
                callback(nil)
            }
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: signUpCallback)
    }

    class func completeRegister(name:String, lastName:String, categories:[Int], favoriteBeaches:[Int]) {
            let dbRef = FIRDatabase.database().reference().child("users")
            let ref = dbRef.child(user!.uid)
        
            let dict = ["name":name, "lastname":lastName]
        
            ref.setValue(dict)
    
    }
    
    class func retrieveUserInfo(callback:@escaping (Error?)->Void) {
        
        let userID = DAOAuth.user?.uid
        FIRDatabase.database().reference().child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            if value != nil {
                let name = value?["name"] as! String
                let lastname = value?["lastname"] as! String
                DAOAuth.user?.name = name
                DAOAuth.user?.lastName = lastname
            }
                callback(nil)
        }) { (error) in
            print("---ERRO DAOAUTH RETRIEVE USER INFO")
            print(error.localizedDescription)
            callback(error)

        }
    }
    
    
}
