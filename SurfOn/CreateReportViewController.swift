//
//  CreateReportViewController.swift
//  SurfOn
//
//  Created by Thiago De Angelis on 05/11/16.
//
//

import Foundation
import UIKit


class CreateReportViewController: UIViewController {
    
    var photoView : UIImageView!
    
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.surfAppColor()
        photoView = UIImageView(frame: CGRect(x: 0, y: 100, width: view.frame.size.width , height: 200 ))
        photoView.backgroundColor = UIColor.blue
        
        
        view.addSubview(photoView)
    }
    
    
    
}
