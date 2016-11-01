//
//  ProfileViewController.swift
//  SurfOn
//
//  Created by Thiago De Angelis on 17/10/16.
//
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    let profileImageView = UIImageView(frame: CGRect(x:101,y:101,width:100,height:100))
    
    func imageCallback(error:Error?) {
        if error == nil {
            profileImageView.image = Session.user?.profileImage
        }
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.surfAppColor()
        self.view.addSubview(profileImageView)
        
        

        DAOAuth.retrieveUserImage(callback: imageCallback)
        profileImageView.backgroundColor = UIColor.white
        
        let nameLabel = UILabel(frame: CGRect(x:101,y:301,width:100,height:100))
        nameLabel.text = (Session.user?.name)! + " " + (Session.user?.lastName)!
        
        self.view.addSubview(nameLabel)
        
    }
    
}
