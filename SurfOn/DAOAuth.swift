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
import FirebaseStorage
import FirebaseAuth

class DAOAuth{

    class func login(email:String, password:String!,callback:@escaping (String?) ->(Void) ) {
        
        func loginCallback (user:FIRUser?, error:Error?) {
            if error != nil {
                callback("erro")
            }
            else {
                func retrieveCallback(error:Error?){
                    callback(error?.localizedDescription)
                }
                Session.user = User(firebaseUser: user!)
                DAO.retrieveUserInfo(callback: retrieveCallback)
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

    class func completeRegister(name:String, lastName:String, country:Country, profilePicture:UIImage?, categories:[Category], favoriteBeaches:[Int]) {
        
        let dbRef = FIRDatabase.database().reference().child("users")
        let user = Session.user
        let ref = dbRef.child(user!.uid)
        
        
        let dict = ["country":country.code,"lastname":lastName,"name":name]
        
        let categoriesDict = NSMutableDictionary()
        for c in categories {
            categoriesDict.addEntries(from: ["\(c.code)":"true"])
        }
        
        
        
        if profilePicture != nil {
        
            let storageRef = FIRStorage.storage().reference(forURL: "gs://surfon-73812.appspot.com")
            let profileRef = storageRef.child("ProfilePictures/"+(user?.uid)! + ".jpg")
            let data = UIImageJPEGRepresentation(profilePicture!, 1.0)
            
            let _ = profileRef.put(data!, metadata: nil) { metadata, error in
                if (error != nil) {
                    // Uh-oh, an error occurred!
                } else {
                    // Metadata contains file metadata such as size, content-type, and download URL.
                    let downloadURL = metadata!.downloadURL
                    print(downloadURL)
                }
            }
            

        
        }
        
        
            ref.setValue(dict)
            ref.child("categories").setValue(categoriesDict)
    
    }
    
    
}
