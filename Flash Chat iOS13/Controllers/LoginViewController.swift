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
        
        if var email = emailOption, var password = passwordOption {
            // for convenience in testing phase only - remove for production:
            if (email == "k") && (password == "k") {
                email = "ken@example.com"
                password = "123456"
            }
            
            if (email == "j") && (password == "j") {
                email = "julie@example.com"
                password = "123456"
            }
            
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
