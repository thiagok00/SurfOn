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
    let code:Int
    
    init (name:String, code:Int) {
        self.name = name
        self.code = code
    }
    
    func getName() ->String{
        return self.name
    }
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.name == rhs.name
    }
}
