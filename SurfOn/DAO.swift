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
            print("---ERRO DAO RETRIEVE CATEGORIES")
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
            print("---ERRO DAO RETRIEVE COUNTRIES")
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
                var location:Location?
                let cityId = beachDict["city_id"] as! String
                
                for l in Session.locations! {
                    if l.cityId == cityId {
                        location = l
                    }
                }
                
                let b = Beach(name: name, latitude: latitude, longitude: longitude, id:v.0 as! String,location:location!)
                beaches.append(b)
                
                }
                callback(beaches)
            }
        }) { (error) in
            print("---ERRO DAO RETRIEVE BEACHES")
            print(error.localizedDescription)
            callback(nil)
        }
        
        
    }
    
    class func getAllLocations(callback:@escaping ([Location]?)->Void) {
        
        FIRDatabase.database().reference().child("cities").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            var locations = [Location]()
            if value != nil {
                
                for v in value! {
                    let cityDict = (v.1 as! NSDictionary)
                    let countryId = cityDict["country_id"] as! String
                    let name = cityDict["name"] as! String
                    
                    var country:Country?
                    for c in Session.countries! {
                        
                        if c.code == countryId {
                            country = c
                        }
                    }
                    
                    let l = Location(cityId: v.0 as! String, cityName: name, country: country!)
                    
                    locations.append(l)
                    
                }
                callback(locations)
            }
        }) { (error) in
            print("---ERRO DAO RETRIEVE BEACHES")
            print(error.localizedDescription)
            callback(nil)
        }
        
        
    }
    
    class func createReport(report:Report) {
    
        let dbRef = FIRDatabase.database().reference().child("reports")
        let ref = dbRef.childByAutoId()
        
        
        let dict = ["author":report.author.uid,"beach_id":report.beach.id,"category_id":report.category.id,"date":NSDate().timeIntervalSince1970,
                    "title":report.title] as [String : Any]
        
    
        ref.setValue(dict)
        
        
        let storageRef = FIRStorage.storage().reference(forURL: "gs://surfon-73812.appspot.com")
        let reportsRef = storageRef.child("ReportPictures/" + ref.key + ".jpg")
        let data = UIImageJPEGRepresentation(report.image!, 0.5)
        
        let _ = reportsRef.put(data!, metadata: nil) { metadata, error in
            if (error != nil) {
                // Uh-oh, an error occurred!
            } else {
                // Metadata contains file metadata such as size, content-type, and download URL.
                let downloadURL = metadata!.downloadURL
                print(downloadURL)
            }
        }
    }

    class func getAllReports(callback:@escaping ([Report]?)->Void) {
    
    FIRDatabase.database().reference().child("reports").queryOrdered(byChild: "date").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            var reports = [Report]()
            if value != nil {
                for v in value! {
                    
                    let reportDict = (v.1 as! NSDictionary)
                    let title = reportDict["title"] as! String
                    let author_id = reportDict["author"] as! String
                    let beach_id = reportDict["beach_id"] as! String
                    let date = NSDate(timeIntervalSince1970: reportDict["date"] as! TimeInterval)
                    let category_id = reportDict["category_id"] as! Int
                    var beach:Beach!
                    var category:Category!
                    
                    
                    for b in Session.beaches! {
                        if b.id == beach_id {
                            beach = b
                        }
                    }
                    
                    for c in Session.categories! {
                        if c.id == category_id {
                            category = c
                        }
                    
                    }
                    
//                    FIRDatabase.database().reference().child("users").observe
                    
                    let r = Report(author: User(uid:author_id, email:""), beach: beach, category: category, title: title, date: date)
                    r.id = v.0 as? String
                    reports.append(r)
                }
    
        }
        callback(reports)
    })
    
}
    

    class func getReportImage(reportId:String,sender:Any,callback:@escaping (UIImage,Any)->Void) {
        let storageRef = FIRStorage.storage().reference(forURL: "gs://surfon-73812.appspot.com")
        
        let islandRef = storageRef.child("ReportPictures/"+reportId+".jpg")

        islandRef.data(withMaxSize: 1 * 1024 * 1024 * 1024) { (data, error) -> Void in
            if (error != nil) {
                // Uh-oh, an error occurred!
            } else {

                let image: UIImage! = UIImage(data: data!)
                callback(image,sender)
            }
        }
    
    }

    class func getUserName(id:String,sender:Any, callback:@escaping (Any,String?)->Void) {
        FIRDatabase.database().reference().child("users").child(id).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            callback(sender,value?["name"] as! String?)
        })
    }
    
    class func postComment(comment:Comment) {
        
        let dbRef = FIRDatabase.database().reference().child("comments").child(comment.reportId).childByAutoId()
        
        let dict = ["title":comment.title,"date":comment.date.timeIntervalSince1970,"author_id":comment.authorId,"author_name":(Session.user?.name!)!] as [String : Any]
        dbRef.setValue(dict)
        
    }
    
    class func getComments(reportId:String, callback:@escaping ([Comment]?)->Void){
        
        FIRDatabase.database().reference().child("comments").child(reportId).queryOrdered(byChild: "date").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            var comments = [Comment]()
            if value != nil {
                for v in value! {
                    
                    let commentDict = (v.1 as! NSDictionary)
                    let title = commentDict["title"] as! String
                    let author_id = commentDict["author_id"] as! String
                    let date = NSDate(timeIntervalSince1970: commentDict["date"] as! TimeInterval)
                    let authorName = commentDict["author_name"] as! String
                    
                    let c = Comment(authorId: author_id, reportId: v.0 as! String, title: title, date: date, authorName: authorName)
                    
                    getUserName(id: author_id, sender: v.0, callback: {(sender,name) in
                        let commentId = sender as! String
                        
                        if name != authorName {
                            FIRDatabase.database().reference().child("comments").child(reportId).child(commentId).child("author_name").setValue(name)
                        }
                        
                    })
                    
                    comments.append(c)
                }
                
            }
            

            func compare (c1:Comment, c2:Comment) -> Bool{
                return c1.date.timeIntervalSince1970 < c2.date.timeIntervalSince1970
            }
            comments.sort(by: compare)
            callback(comments)
        })
        
    }
    

}
