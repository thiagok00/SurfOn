//
//  CategoriesTBVC.swift
//  SurfOn
//
//  Created by Thiago De Angelis on 31/10/16.
//
//

import Foundation
import UIKit

protocol CategoriesHandler {
    func markedCategory(category:Category)
    func unmarkedCategory(category:Category)
}

class CategoriesTBVC: UITableViewController {
    
    var categories = [Category]()
    var delegate:CategoriesHandler?
    
    override func viewDidLoad() {
    
        tableView.tableFooterView = UIView(frame:CGRect.zero)
        self.tableView.isScrollEnabled = false
        
        func callback(categories:[Category]?) {
            if categories != nil {
                self.categories = categories!
                self.tableView.reloadData()
            }
        }
        DAOAuth.getAllCategories(callback: callback)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "category")
        
        cell.textLabel?.text = categories[indexPath.row].getName()
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cellcheck = tableView.cellForRow(at: indexPath)
       
        if (cellcheck!.accessoryType == .none) {
            cellcheck!.accessoryType = .checkmark
            self.delegate?.markedCategory(category: categories[indexPath.row])
        }
        else {
            cellcheck!.accessoryType = .none
            self.delegate?.unmarkedCategory(category: categories[indexPath.row])

        }
    }
    
    
    
}
