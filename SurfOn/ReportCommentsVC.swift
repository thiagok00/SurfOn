//
//  ReportCommentsViewController.swift
//  SurfOn
//
//  Created by Thiago De Angelis on 28/11/16.
//
//

import Foundation
import UIKit



class ReportCommentsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    var report:Report!
    var comments = [Comment]()
    var inputComment:UITextField!
    var commentsTableView : UITableView!
    
    func setAuthorName(sender:Any, name:String?) {
        let label = sender as! UILabel
        label.text = name
    }
    
    func getComments(comments:[Comment]?) {
        if comments != nil {
            self.comments = comments!
            self.commentsTableView.reloadData()
            
            if comments!.count > 0 {
                let lastRow = IndexPath(item: comments!.count - 1, section: 0)
                
                self.commentsTableView.selectRow(at: lastRow, animated: true, scrollPosition: UITableViewScrollPosition.bottom)
            }
        }
    }
    
    override func viewDidLoad() {
        let authorNameLabel = UILabel(frame: CGRect(x:0,y:20,width:400,height:50))
        DAO.getUserName(id: report.author.uid,sender: authorNameLabel, callback: setAuthorName)
        
        
        
        
        self.view.backgroundColor = UIColor.surfAppColor()
        let imageViewController = UIImageView(frame: CGRect(x:0,y:130,width:300,height:300))
        
        if report.image == nil {
            DAO.getReportImage(reportId: report.id!, sender: report, callback: { (image,sender) in
                self.report.image = image
                imageViewController.image = image
            })
        }
        else {
            imageViewController.image = report.image
        }
        
        let locationLabel = UILabel(frame: CGRect(x:0,y:60,width:400,height:50))
        let titleLabel = UILabel(frame: CGRect(x:0,y:440,width:400,height:50))
        
        authorNameLabel.text = "placeholder"
        locationLabel.text = report.beach.name + ", " + report.beach.location.cityName + ", " + ", " + report.beach.location.country.name
        titleLabel.text = report.title
        
        commentsTableView = UITableView(frame: CGRect(x: 0, y: 450, width: 400, height: 170))
        commentsTableView.dataSource = self
        commentsTableView.delegate = self
        
        
        inputComment = UITextField(frame: CGRect(x: 5, y: self.view.frame.height - 90, width: 400, height: 50))
        inputComment.placeholder = "Comment something..."
        inputComment.delegate = self
        
        let postButton = UIButton(frame: CGRect(x: self.view.frame.width - 40, y: 0, width: 40, height: 50) )
        postButton.backgroundColor = UIColor.red
        postButton.addTarget(self, action: #selector(ReportCommentsVC.postComment), for: UIControlEvents.touchUpInside)
        postButton.center.y = inputComment.center.y
        
        view.addSubview(authorNameLabel)
        view.addSubview(locationLabel)
        view.addSubview(titleLabel)
        view.addSubview(imageViewController)
        view.addSubview(commentsTableView)
        view.addSubview(inputComment)
        view.addSubview(postButton)
        
        DAO.getComments(reportId: report.id!, callback: getComments)
        
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func postComment() {
        if inputComment.text != nil {
            let c = Comment(authorId: (Session.user?.uid)!,reportId:report.id!, title: inputComment.text!, authorName: (Session.user?.name!)!)
            DAO.postComment(comment: c)
            inputComment.text = ""
            DAO.getComments(reportId: report.id!, callback: getComments)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "comments")
        let c = comments[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        let dateString = dateFormatter.string(from: c.date as Date)
        cell.textLabel?.text = dateString + " " + c.authorName + ": " + c.title

        return cell
    }
    
}
