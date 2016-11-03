//
//  Extension.swift
//  SurfOn
//
//  Created by Thiago De Angelis on 17/10/16.
//
//

import Foundation
import UIKit


extension UIColor {
    
    static func surfAppColor()->UIColor {
        return UIColor(red: 0, green: 136/255, blue: 204/255, alpha: 1)
    }
    

}


extension Array where Element: Equatable
{
    mutating func removeObject(object: Element) {
        
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}
