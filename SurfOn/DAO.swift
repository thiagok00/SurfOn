//
//  DAO.swift
//  Surf On
//
//  Created by Thiago De Angelis on 24/08/16.
//  Copyright © 2016 puc. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class DAO {
 
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
                    let cat =  Category(name: value?["\(i)"] as! String, id: i)
                    categories.append(cat)
                    i = i + 1
                }
                func compare (c1:Category, c2:Category)->Bool {
                    return c1.id < c2.id
                }
                categories.sort(by: compare)
                callback(categories)
            }
        }) { (error) in
            print("---ERRO DAOAUTH RETRIEVE CATEGORIES")
            print(error.localizedDescription)
            callback(nil)
        }
        
        
    }

    class func getAllCountries(callback:@escaping ([Country]?)->Void) {
        FIRDatabase.database().reference().child("countries").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            var countries = [Country]()
            if value != nil {
                
                for v in value! {
                    let code = v.0 as! String
                    let englishName = v.1 as! String
                    let c = Country(name: englishName, code: code)
                    countries.append(c)
                
                }
                
                func compare (c1:Country, c2:Country) -> Bool{
                    return c1.name < c2.name
                }
                countries.sort(by: compare)
                
                
                callback(countries)
            }
        }) { (error) in
            print("---ERRO DAOAUTH RETRIEVE CATEGORIES")
            print(error.localizedDescription)
            callback(nil)
        }
        
    }
    
    
    class func getAllBeaches(callback:@escaping ([Beach]?)->Void) {
        
        FIRDatabase.database().reference().child("beaches").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            var beaches = [Beach]()
            if value != nil {
            
            for v in value! {
                let beachDict = (v.1 as! NSDictionary)
                let name = beachDict["name"] as! String
                let latitude:CGFloat = beachDict["latitude"] as! CGFloat
                let longitude:CGFloat = beachDict["longitude"] as! CGFloat
                
                let b = Beach(name: name, latitude: latitude, longitude: longitude, id:v.0 as! String)
                beaches.append(b)
                
                }
                
//                for v in value! {
//                    let k = v as! NSDictionary

//                    
//                }
                
//                func compare (c1:Country, c2:Country) -> Bool{
//                    return c1.name < c2.name
//                }
//                countries.sort(by: compare)
                
                
                callback(beaches)
            }
        }) { (error) in
            print("---ERRO DAOAUTH RETRIEVE BEACHES")
            print(error.localizedDescription)
            callback(nil)
        }
        
        
    }
    
    class func createReport(report:Report) {
    
        let dbRef = FIRDatabase.database().reference().child("reports")
        let ref = dbRef.childByAutoId()
        
        
        let dict = ["author":report.author.uid,"beach_id":report.beach.id,"category_id":report.category.id, "title":report.title] as [String : Any]
        
    
        ref.setValue(dict)
    
    }
    
    
    
    
}
