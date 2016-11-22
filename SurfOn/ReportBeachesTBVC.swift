//
//  CategoriesTBVC.swift
//  SurfOn
//
//  Created by Thiago De Angelis on 31/10/16.
//
//

import Foundation
import UIKit

protocol ReportBeachDelegate {
    func selected(beach:Beach?)
}



class ReportBeachTBVC: UITableViewController {
    
    var beaches = [Beach]()
    var selectedBeach:Beach?
    var delegate:ReportBeachDelegate?
    
    func callback(beaches:[Beach]?) {
        if beaches != nil {
            self.beaches = beaches!
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        
        tableView.tableFooterView = UIView(frame:CGRect.zero)
        self.tableView.isScrollEnabled = false
        
        
        if(beaches.count == 0) {
            DAO.getAllBeaches(callback: callback)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beaches.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "beach")
        
        let beach = beaches[indexPath.row]
        
        cell.textLabel?.text = beach.name

        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let cellcheck = tableView.cellForRow(at: indexPath)
            let cellBeach = beaches[indexPath.row]
            
            if cellBeach == selectedBeach {
                cellcheck?.accessoryType = .none
                selectedBeach = nil
            }
            else {
                cellcheck?.accessoryType = .checkmark
                
                if selectedBeach != nil {
                    let row = beaches.index(of: selectedBeach!)!
                    let index = IndexPath(item: row, section: 0)
                    let lastCell = tableView.cellForRow(at: index)
                    lastCell?.accessoryType = .none
                }
                selectedBeach = cellBeach
                
            }
            delegate?.selected(beach: selectedBeach)
        
    }
    
    
}
