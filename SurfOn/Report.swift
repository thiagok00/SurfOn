//
//  Report.swift
//  SurfOn
//
//  Created by Thiago De Angelis on 22/11/16.
//
//

import Foundation
import UIKit

class Report {
    
    let author:User
    var image:UIImage?
    let beach:Beach
    let category:Category
    let title:String
    let date:NSDate
    var id:String?
    
    
    init (author:User, image:UIImage, beach:Beach, category:Category, title:String) {
        self.author = author
        self.image = image
        self.beach = beach
        self.category = category
        self.title = title
        self.date = NSDate()
    }
    init (author:User, beach:Beach, category:Category, title:String, date:NSDate) {
        self.author = author
        self.beach = beach
        self.category = category
        self.title = title
        self.date = NSDate()
    }
    
    
}
