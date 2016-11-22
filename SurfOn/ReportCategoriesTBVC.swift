//
//  CategoriesTBVC.swift
//  SurfOn
//
//  Created by Thiago De Angelis on 31/10/16.
//
//

import Foundation
import UIKit

protocol ReportCategoryDelegate {
    func selected(category:Category?)
}



class ReportCategoriesTBVC: UITableViewController {
    
    var categories = [Category]()
    var selectedCategory:Category?
    var delegate:ReportCategoryDelegate?
    
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
        if indexPath.row ==  0 {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > 0 {
            let cellcheck = tableView.cellForRow(at: indexPath)
            let cellCategory = categories[indexPath.row]
            
            if cellCategory == selectedCategory {
                cellcheck?.accessoryType = .none
                selectedCategory = nil
            }
            else {
                cellcheck?.accessoryType = .checkmark
                
                if selectedCategory != nil {
                    let row = categories.index(of: selectedCategory!)!
                    let index = IndexPath(item: row, section: 0)
                    let lastCell = tableView.cellForRow(at: index)
                    lastCell?.accessoryType = .none
                }
                selectedCategory = cellCategory

            }
            delegate?.selected(category: selectedCategory)
        }
    }
    
    
}
