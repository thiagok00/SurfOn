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
    
    
    
    override func viewDidLoad() {
        tabBarController?.delegate = self
        self.delegate = self
        
        let mapVC = MapViewController()
        let firstVC = UINavigationController(rootViewController: mapVC)
        
        let feedVC = FeedViewController(collectionViewLayout: UICollectionViewFlowLayout() )
        let secondVC = UINavigationController(rootViewController: feedVC)
        
        let profileVC = ProfileViewController()
        let thirdVC = UINavigationController(rootViewController: profileVC)
        
        let item1 = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.history, tag: 0)
        let item2 = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.favorites, tag: 0)
        let item3 = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.contacts, tag: 0)

        firstVC.tabBarItem = item1
        secondVC.tabBarItem = item2
        thirdVC.tabBarItem = item3
        self.viewControllers = [firstVC, secondVC, thirdVC]


        
        
    }
    
    
    
    
}
