//
//  Location.swift
//  SurfOn
//
//  Created by Thiago De Angelis on 28/11/16.
//
//

import Foundation


class Location {
    
    let cityId:String
    let cityName:String
    let country:Country
    
    init (cityId:String, cityName:String, country:Country) {
        self.cityId = cityId
        self.cityName = cityName
        self.country = country
    
    }
    
    
}
