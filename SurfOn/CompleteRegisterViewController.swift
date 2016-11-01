//
//  CompleteRegisterViewController.swift
//  SurfOn
//
//  Created by Thiago De Angelis on 16/08/16.
//  Copyright © 2016 puc. All rights reserved.
//

import Foundation
import UIKit

class CompleteRegisterViewController :UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, CategoriesHandler {
    
    var pictureImageView:UIImageView!
    var nameTextField:UITextField!
    var lastNameTextField:UITextField!
    var categories:[Category] = []
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.surfAppColor()
        
        self.navigationController?.title = "Surf On"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(CompleteRegisterViewController.doneItemPressed))
        
        pictureImageView = UIImageView(frame: CGRect(x: 0,y: 0,width: 100,height: 100))
        pictureImageView.layer.cornerRadius = 50
        pictureImageView.center.x = view.center.x
        pictureImageView.center.y = 200
        pictureImageView.backgroundColor = UIColor.black
        pictureImageView.layer.masksToBounds = true;
        
        
        let changePicButton = UIButton(frame: CGRect(x: 0,y: 0,width: 150,height: 20))
        changePicButton.setTitle("Change Profile Photo", for: UIControlState())
        changePicButton.titleLabel?.font = UIFont(name: "Arial", size: 10)
        changePicButton.setTitleColor(UIColor(red: 6/255, green: 69/255, blue: 173/255, alpha: 1), for: UIControlState())
        changePicButton.center.x = pictureImageView.center.x
        changePicButton.center.y = pictureImageView.center.y + pictureImageView.frame.height/2 + changePicButton.frame.height/2
        changePicButton.addTarget(self, action: #selector(CompleteRegisterViewController.changePicButPressed), for: UIControlEvents.touchUpInside)
        
        nameTextField = UITextField(frame: CGRect(x: 0,y: 0,width: 200,height: 30))
        nameTextField.placeholder = "Name"
        nameTextField.backgroundColor = UIColor.white
        nameTextField.center.x = view.center.x
        nameTextField.center.y = pictureImageView.center.y + 200
        
        lastNameTextField = UITextField(frame: CGRect(x: 0,y: 0,width: 200,height: 30))
        lastNameTextField.placeholder = "Last Name"
        lastNameTextField.backgroundColor = UIColor.white
        lastNameTextField.center.x = view.center.x
        lastNameTextField.center.y = nameTextField.center.y + 35
        
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 150))
        tableView.center.y = lastNameTextField.center.y + 150
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        self.view.addSubview(pictureImageView)
        self.view.addSubview(changePicButton)
        self.view.addSubview(nameTextField)
        self.view.addSubview(lastNameTextField)
        self.view.addSubview(tableView)
     
        //REMOVER, APENAS TESTE
        if Session.user?.name != nil {
            nameTextField.text = Session.user?.name
            lastNameTextField.text = Session.user?.lastName
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        pictureImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage; dismiss(animated: true, completion: nil)
        
    }
    
    
    func changePicButPressed() {
        
        let alert = UIAlertController(title: "Change Profile Photo", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let remove = UIAlertAction(title: "Remove Current Photo", style: UIAlertActionStyle.default , handler: {
            (alert:UIAlertAction!) in
            
            self.pictureImageView.image = nil
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
    
    func doneItemPressed() {
        if (nameTextField.text == nil || nameTextField.text!.characters.count < 4) {
            print("Invalid Name")
        }
        else {
            DAOAuth.completeRegister(name: nameTextField.text!, lastName: lastNameTextField.text!,profilePicture: pictureImageView.image ,categories: [Int](), favoriteBeaches: [Int]())
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "options")
        
        if indexPath.row == 0 {
            cell.textLabel?.text = "Country"
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        }
        else if indexPath.row == 1 {
            cell.textLabel?.text = "Favorite Beachs"
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            
        }
        else if indexPath.row == 2 {
            cell.textLabel?.text = "Categories"
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            let vc = CategoriesTBVC()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }

    func markedCategory(category: Category) {
        categories.append(category)
    }
    
    func unmarkedCategory(category: Category) {
   //     categories.remove
    }
    
}
