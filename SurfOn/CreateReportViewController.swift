//
//  CreateReportViewController.swift
//  SurfOn
//
//  Created by Thiago De Angelis on 05/11/16.
//
//

import Foundation
import UIKit


class CreateReportViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, ReportCategoryDelegate, ReportBeachDelegate, UITextFieldDelegate {
    
    var photoView : UIButton!
    var selectedCategory:Category?
    var selectedBeach:Beach?
    var titleTextField = UITextField(frame: CGRect(x: 18, y: 0, width: 320, height: 50 ))

    let tableView = UITableView(frame: CGRect(x: 0, y: 400, width: 400, height: 200))
    
    
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.surfAppColor()
        photoView = UIButton(frame: CGRect(x: 0, y: 100, width: view.frame.size.width , height: 200 ))
        photoView.backgroundColor = UIColor.blue
        photoView.addTarget(self, action: #selector(CreateReportViewController.tap), for: UIControlEvents.touchUpInside)
        
        titleTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(CreateReportViewController.createReport))
        
        
        view.addSubview(tableView)
        view.addSubview(photoView)
    }
    
    func createReport() {
    
        let report = Report(author: Session.user!, image: photoView.backgroundImage(for: UIControlState.normal)!, beach: selectedBeach!, category: selectedCategory!, title: titleTextField.text!)
        DAO.createReport(report: report)
    
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func tap() {
        
        let alert = UIAlertController(title: "Change Profile Photo", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let remove = UIAlertAction(title: "Remove Current Photo", style: UIAlertActionStyle.default , handler: {
            (alert:UIAlertAction!) in
            
            self.photoView.setBackgroundImage(nil, for: UIControlState.normal)
        })
        let take = UIAlertAction(title: "Take Photo", style: UIAlertActionStyle.default , handler:  {
            (alert:UIAlertAction!) in
            
            let imagePicker =  UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            
            self.present(imagePicker, animated: true, completion: nil)
            
        })
        
        let choose = UIAlertAction(title: "Choose from Library", style: UIAlertActionStyle.default , handler: {
            (alert:UIAlertAction!) in
            
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            self.present(picker, animated: true, completion: nil)
            
        })
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(remove)
        alert.addAction(take)
        alert.addAction(choose)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //photoView.image = ; dismiss(animated: true, completion: nil)
        photoView.setBackgroundImage(info[UIImagePickerControllerOriginalImage] as? UIImage, for: UIControlState.normal)
        dismiss(animated: true, completion: nil)
    }
    
    
    /*tableview*/
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cellreport")
        
        if indexPath.row == 0 {
            cell.contentView.addSubview(titleTextField)
        }
       else if indexPath.row == 1 {
            cell.textLabel?.text = "Categories"
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            if selectedCategory != nil {
                cell.detailTextLabel?.text = selectedCategory?.getName()
                print(selectedCategory!.getName())
            }
        }
        else if indexPath.row == 2 {
            cell.textLabel?.text = "Beach"
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            if selectedBeach != nil {
                cell.detailTextLabel?.text = selectedBeach?.name
                print(selectedBeach!.name)
            }

        }
        
        return cell
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
        if indexPath.row == 0 {
        }
        else if indexPath.row == 1 {
            let vc = ReportCategoriesTBVC()
            vc.selectedCategory = selectedCategory
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 2 {
            let vc = ReportBeachTBVC()
            vc.selectedBeach = selectedBeach
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        
        }
        
        
    }
 
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
 
    
    func selected(category: Category?) {
        self.selectedCategory = category
    }
    
    func selected(beach: Beach?) {
        self.selectedBeach = beach
    }
    
    
}
