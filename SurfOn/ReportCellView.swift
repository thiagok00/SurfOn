//
//  ReportCellView.swift
//  SurfOn
//
//  Created by Thiago De Angelis on 28/11/16.
//
//

import Foundation
import UIKit

class ReportCellView: UIView {
    var titleLabel:UILabel!
    var locationLabel:UILabel!
    var imageView: UIImageView!
    var authorLabel:UILabel!
    
    init () {
    
        super.init(frame: CGRect(x: 0, y: 0, width: 500, height: 500 ))
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 50 ))
            
        locationLabel = UILabel(frame: CGRect(x: 0, y: 60, width: 400, height: 50 ))
        imageView = UIImageView(frame: CGRect(x: 0, y: 120, width: 300, height: 300 ))
        imageView.backgroundColor = UIColor.blue
        authorLabel = UILabel(frame: CGRect(x: 0, y: 430 , width: 400, height: 50))
        
        self.addSubview(titleLabel)
        self.addSubview(locationLabel)
        self.addSubview(imageView)
        self.addSubview(authorLabel)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
