//
//  FeedViewController.swift
//  SurfOn
//
//  Created by Thiago De Angelis on 20/10/16.
//
//

import Foundation
import UIKit

class FeedViewController: UITableViewController {

    var reports = [Report]()
    
    
    func getReports(reports:[Report]?) {
        if reports != nil {
            self.reports = reports!
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        tableView.tableFooterView = UIView(frame:CGRect.zero)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:#selector( FeedViewController.createReport))

        DAO.getAllReports(callback: getReports)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        DAO.getAllReports(callback: getReports)
        tableView.reloadData()
    }
    
    func createReport() {
        navigationController?.pushViewController(CreateReportViewController(), animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    
    func callbackImage( image:UIImage, sender:Any) {
        let report = sender as! Report
        report.image = image
        tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "reports")
        let report = reports[indexPath.row]

        let view =  ReportCellView()
        view.authorLabel.text = report.author.name
        view.titleLabel.text = report.title
        view.locationLabel.text = report.beach.name + ", " + report.beach.location.cityName + ", " + report.beach.location.country.name
        
        
        if report.image == nil {
            DAO.getReportImage(reportId: report.id!, sender: report, callback: callbackImage)
        }
        else {
            view.imageView.image = report.image
        }
        
        cell.contentView.addSubview(view)
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ReportCommentsVC()
        vc.report = reports[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reports.count
    }
    
}
