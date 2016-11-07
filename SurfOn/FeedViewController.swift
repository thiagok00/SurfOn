//
//  FeedViewController.swift
//  SurfOn
//
//  Created by Thiago De Angelis on 20/10/16.
//
//

import Foundation
import UIKit

class FeedViewController: UICollectionViewController {


    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor.surfAppColor()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:#selector( FeedViewController.createReport))
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "report")
        
        
        
    }
    
    func createReport() {
        navigationController?.pushViewController(CreateReportViewController(), animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.surfAppColor()
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0 
    }
    
}
