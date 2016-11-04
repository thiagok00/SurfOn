//
//  Country.swift
//  SurfOn
//
//  Created by Thiago De Angelis on 04/11/16.
//
//

import Foundation

class Country : Equatable {
    
    let name:String!
    let code:String!
    
    
    init(name:String, code:String) {
        self.name = name
        self.code = code
    }
    
    
    static func == (lhs: Country, rhs: Country) -> Bool {
        return lhs.name == rhs.name
    }

    
}
