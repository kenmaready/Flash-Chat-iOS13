//
//  ErrorAlert.swift
//  Flash Chat iOS13
//
//  Created by Ken Maready on 7/5/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit

struct ErrorAlert {
    // error popup alert
    static func show(message: String, sender: UIViewController) {
        let alert = UIAlertController(title: "Registration Error", message: message, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
            NSLog("OK was selected")
        }
        alert.addAction(okAction)
        
        sender.present(alert, animated: true, completion: nil)
    }
  
}
