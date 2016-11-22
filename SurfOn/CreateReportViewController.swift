//
//  CreateReportViewController.swift
//  SurfOn
//
//  Created by Thiago De Angelis on 05/11/16.
//
//

import Foundation
import UIKit


class CreateReportViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var photoView : UIButton!
    var selectedCategory:Category?
    let tableView = UITableView(frame: CGRect(x: 0, y: 300, width: 300, height: 200))
    
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.surfAppColor()
        photoView = UIButton(frame: CGRect(x: 0, y: 100, width: view.frame.size.width , height: 200 ))
        photoView.backgroundColor = UIColor.blue
        photoView.addTarget(self, action: #selector(CreateReportViewController.tap), for: UIControlEvents.touchUpInside)
        
        
        
        view.addSubview(tableView)
        view.addSubview(photoView)
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cellreport")
        
        cell.textLabel?.text = "Categories"
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        return cell
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = ReportCategoriesTBVC()
        vc.selectedCategory = selectedCategory
        self.present(vc, animated: true, completion: nil)
    }
 
 
    
    
    
    
    
}
