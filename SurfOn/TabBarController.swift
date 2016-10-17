//
//  TabBarController.swift
//  SurfOn
//
//  Created by Thiago De Angelis on 17/10/16.
//
//

import Foundation
import UIKit


class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    
    let profileVC = ProfileViewController()
    
    override func viewDidLoad() {
        tabBarController?.delegate = self
        self.delegate = self
        
        let item1 = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.contacts, tag: 0)
        
        profileVC.tabBarItem = item1
        self.viewControllers = [profileVC]


        
        
    }
    
    
    
    
}
