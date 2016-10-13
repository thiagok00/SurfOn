//
//  ViewController.swift
//  Surf On
//
//  Created by Thiago De Angelis on 16/08/16.
//  Copyright © 2016 puc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    var emailTextField:UITextField!
    var passwordTextField:UITextField!
    var loginButton:UIButton!
    var registerButton:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        //        RGB: (0, 136, 204)
        self.view.backgroundColor = UIColor(red: 0, green: 136/255, blue: 204/255, alpha: 1)
        
        let titleLabel = UILabel(frame: CGRect(x: 0,y: 0,width: 400, height: 200))
        titleLabel.text = "Surf On"
        titleLabel.textAlignment = .center
        titleLabel.center.x = view.center.x
        titleLabel.font = UIFont(name: "BradleyHandITCTT-Bold" , size: 60)
        
        
        emailTextField = UITextField(frame: CGRect(x: 0,y: 0,width:250,height: 30))
        emailTextField.delegate = self
        emailTextField.center = view.center
        emailTextField.center.y = view.center.y
        emailTextField.backgroundColor = UIColor.white
        emailTextField.placeholder = "Email"
        emailTextField.layer.cornerRadius = 10
        emailTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)

        passwordTextField = UITextField(frame: CGRect(x: 0,y: 0,width: 250,height: 30))
        passwordTextField.delegate = self
        passwordTextField.center.x = view.center.x
        passwordTextField.center.y = emailTextField.center.y + 40
        passwordTextField.backgroundColor = UIColor.white
        passwordTextField.placeholder = "Password"
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        passwordTextField.isSecureTextEntry = true

        loginButton = UIButton(frame: CGRect(x: 0,y: 0,width: 250,height: 35))
        loginButton.backgroundColor = UIColor(red: 0, green: 166/255, blue: 234/255, alpha: 1)
        loginButton.center.x = view.center.x
        loginButton.center.y = passwordTextField.center.y + 40
        loginButton.setTitle("Log in", for: UIControlState.normal)
        loginButton.addTarget(self, action: #selector(LoginViewController.loginButtonPressed), for: UIControlEvents.touchUpInside)
        
        registerButton = UIButton(frame: CGRect(x:0,y: 0,width: 250,height: 35))
        registerButton.backgroundColor = UIColor(red: 0, green: 166/255, blue: 234/255, alpha: 1)
        registerButton.center.x = view.center.x
        registerButton.center.y = loginButton.center.y + 40
        registerButton.setTitle("Register", for: UIControlState.normal)
        registerButton.addTarget(self, action: #selector(LoginViewController.registerButtonPressed), for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(loginButton)
        self.view.addSubview(registerButton)
    }
    


    func loginCallBack(error:String?) {
        
        if (error != nil) {
            let alert = UIAlertController(title: "Error", message: error!, preferredStyle: UIAlertControllerStyle.alert)
            let cancel = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
            
            alert.addAction(cancel)
            self.present(alert, animated: false, completion: nil)
        }
        else {
            let vc = CompleteRegisterViewController()
            let nav = UINavigationController(rootViewController: vc)
            self.present(nav, animated: true, completion: nil)
        }
    
    }
    
    
    func loginButtonPressed() {
        
        DAOAuth.login(email: emailTextField.text!, password: passwordTextField.text!, callback: loginCallBack)
        
    }
    
    func registerCallback(error:String?) {
    
        if (error != nil) {
            let alert = UIAlertController(title: "Error", message: error!, preferredStyle: UIAlertControllerStyle.alert)
            let cancel = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
            
            alert.addAction(cancel)
            self.present(alert, animated: false, completion: nil)
        }

    }

    func registerButtonPressed() {
        DAOAuth.register(email: emailTextField.text!, password: passwordTextField.text!, callback: registerCallback)
    
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    

}

