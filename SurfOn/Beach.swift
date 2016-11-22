//
//  Beach.swift
//  SurfOn
//
//  Created by Thiago De Angelis on 22/11/16.
//
//

import Foundation
import UIKit

class Beach:Equatable {
    
    let name:String
    let city:String
    let country:String
    let latitude:CGFloat
    let longitude:CGFloat
    let id:String
    
    init (name:String, latitude:CGFloat, longitude:CGFloat, id:String) {
        self.name = name
        self.city = ""
        self.country = ""
        self.latitude = latitude
        self.longitude = longitude
        self.id = id
    }
    
    static func == (lhs: Beach, rhs: Beach) -> Bool {
        return lhs.name == rhs.name
    }
    
}
