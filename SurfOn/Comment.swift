//
//  Comment.swift
//  SurfOn
//
//  Created by Thiago De Angelis on 28/11/16.
//
//

import Foundation

class Comment: Equatable{
    
    var authorId:String!
    var reportId:String!
    var title:String!
    var date:NSDate!
    var authorName:String!
    
    init(authorId:String,reportId:String, title:String, authorName:String) {
        self.authorId = authorId
        self.title = title
        self.reportId = reportId
        self.date = NSDate()
    }
    
    init(authorId:String, reportId:String, title:String, date:NSDate, authorName:String) {
        self.authorId = authorId
        self.reportId = reportId
        self.title = title
        self.date = date
        self.authorName = authorName
    }
    static func == (lhs: Comment, rhs: Comment) -> Bool {
        return lhs.date == rhs.date
    }

}
