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

    class func completeRegister(name:String, lastName:String, profilePicture:UIImage?, categories:[Int], favoriteBeaches:[Int]) {
        
        let dbRef = FIRDatabase.database().reference().child("users")
        let user = Session.user
        let ref = dbRef.child(user!.uid)
        
        
        let dict = ["name":name, "lastname":lastName]
        
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
    
    }
    
    class func retrieveUserInfo(callback:@escaping (Error?)->Void) {
        
        let userID = Session.user?.uid
        FIRDatabase.database().reference().child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            if value != nil {
                let name = value?["name"] as! String
                let lastname = value?["lastname"] as! String
                Session.user?.name = name
                Session.user?.lastName = lastname
            }
                callback(nil)
        }) { (error) in
            print("---ERRO DAOAUTH RETRIEVE USER INFO")
            print(error.localizedDescription)
            callback(error)

        }
    }
    
    class func retrieveUserImage(callback:@escaping (Error?)->Void) {
        let storageRef = FIRStorage.storage().reference(forURL: "gs://surfon-73812.appspot.com")
        
        let islandRef = storageRef.child("ProfilePictures/"+(Session.user?.uid)!+".jpg")
        // Create local filesystem URL
        
        
        islandRef.data(withMaxSize: 1 * 1024 * 1024 * 1024) { (data, error) -> Void in
            if (error != nil) {
                // Uh-oh, an error occurred!
            } else {
                // Data for "images/island.jpg" is returned
                let image: UIImage! = UIImage(data: data!)
                Session.user?.profileImage = image
                
            }
            callback(nil)
        }
    }
    
    class func getAllCategories(callback:@escaping ([Category]?)->Void) {
    
        FIRDatabase.database().reference().child("categories").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            var categories = [Category]()
            if value != nil {
                let amountCategories = value?["amount"] as! Int
                var i = 0
                while ( i < amountCategories ) {
                    let cat =  Category(name: value?["\(i)"] as! String)
                    categories.append(cat)
                    i = i + 1
                }
                callback(categories)
            }
        }) { (error) in
            print("---ERRO DAOAUTH RETRIEVE CATEGORIES")
            print(error.localizedDescription)
            callback(nil)
        }
        
    
    }
    
    
    
    
}
