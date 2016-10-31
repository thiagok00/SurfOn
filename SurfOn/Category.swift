//
//  Category.swift
//  SurfOn
//
//  Created by Thiago De Angelis on 31/10/16.
//
//

import Foundation

class Category {
    
    private let name:String!
    
    init (name:String) {
        self.name = name
    }
    
    func getName() ->String{
        return self.name
    }
    
    
}
