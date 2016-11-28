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
    let latitude:CGFloat
    let longitude:CGFloat
    let id:String
    let location:Location
    
    
    init (name:String, latitude:CGFloat, longitude:CGFloat, id:String, location:Location) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.id = id
        self.location = location
    }
    
    static func == (lhs: Beach, rhs: Beach) -> Bool {
        return lhs.name == rhs.name
    }
    
}
