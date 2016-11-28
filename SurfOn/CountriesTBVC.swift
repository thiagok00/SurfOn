//
//  CountriesTBVC.swift
//  SurfOn
//
//  Created by Thiago De Angelis on 04/11/16.
//
//

import Foundation
import UIKit

class CountrieTBVC: UITableViewController {

    var countries = [Country]()
    var markedCell : UITableViewCell?
    
    
    func callback(countries:[Country]?){
        self.countries = countries!
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        if Session.countries != nil {
            countries = Session.countries!
        }
        else {
            DAO.getAllCountries(callback: callback)
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "country")

        cell.textLabel?.text = countries[indexPath.row].name
        cell.accessoryType = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cellcheck = tableView.cellForRow(at: indexPath)
        
        if (cellcheck!.accessoryType == .none) {
            cellcheck!.accessoryType = .checkmark
        }
        else {
            cellcheck!.accessoryType = .none
            
        }
        if cellcheck != markedCell {
            markedCell?.accessoryType = .none
            markedCell = cellcheck
            Session.user?.country = countries[indexPath.row]
        }
        else {
            Session.user?.country = nil
        
        }
    
    }
    
    
    
}
