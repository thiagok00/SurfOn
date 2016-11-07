//
//  Category.swift
//  SurfOn
//
//  Created by Thiago De Angelis on 31/10/16.
//
//

import Foundation

class Category: Equatable {
    
    private let name:String!
    let id:Int
    
    init (name:String, id:Int) {
        self.name = name
        self.id = id
    }
    
    func getName() ->String{
        return self.name
    }
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.name == rhs.name
    }
}
