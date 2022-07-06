//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    @IBAction func loginPressed(_ sender: UIButton) {
        let emailOption = emailTextfield.text
        let passwordOption = passwordTextfield.text
        if let email = emailOption, let password = passwordOption {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    ErrorAlert.show(message: e.localizedDescription, sender: self)
                } else {
                    self.performSegue(withIdentifier: K.Segues.LoginToChat, sender: self)
                }
            }
        }
    }
    
}
