//
//  CategoriesTBVC.swift
//  SurfOn
//
//  Created by Thiago De Angelis on 31/10/16.
//
//

import Foundation
import UIKit

class CategoriesTBVC: UITableViewController {
    
    var categories = [Category]()
    
    func callback(categories:[Category]?) {
        if categories != nil {
            self.categories = categories!
            self.tableView.reloadData()
            Session.categories = categories
        }
    }
    
    override func viewDidLoad() {
    
        tableView.tableFooterView = UIView(frame:CGRect.zero)
        self.tableView.isScrollEnabled = false
        
        if(Session.categories == nil) {
            DAO.getAllCategories(callback: callback)
        }
        else {
            categories = Session.categories!
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "category")
        
        let category = categories[indexPath.row]
        
        cell.textLabel?.text = category.getName()
        if let _ = Session.user?.categories.index(of: category) {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cellcheck = tableView.cellForRow(at: indexPath)
        let selectedCategory = categories[indexPath.row]
        
        if (cellcheck!.accessoryType == .none) {
            cellcheck!.accessoryType = .checkmark
            Session.user?.categories.append(selectedCategory)
        }
        else {
            cellcheck!.accessoryType = .none
            Session.user?.categories.removeObject(object:selectedCategory)
            
        }
    }
    
    
    
}
