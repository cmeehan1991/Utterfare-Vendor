//
//  LogInViewController.swift
//  Utterfare Vendor
//
//  Created by Connor Meehan on 3/27/18.
//  Copyright © 2018 CBM Web Development. All rights reserved.
//

import Foundation
import UIKit

class LogInViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let defaults = UserDefaults.standard
    
    @IBAction func signInAction(){
        activityIndicator.startAnimating()
        let logInModel = LogInModel()
        logInModel.logIn(username: usernameTextField.text!, password: passwordTextField.text!)
        if defaults.bool(forKey: "IS_LOGGED_IN"){
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
            self.navigationController?.pushViewController(newViewController, animated: true)
        }else{
           logInError()
        }
        activityIndicator.stopAnimating()
    }
    
    func logInError(){
        let alert = UIAlertController(title: "Log In Error", message: "The username and password do not match what we have on file.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: {
            self.passwordTextField.text = ""
            self.usernameTextField.becomeFirstResponder()
        })
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
}
