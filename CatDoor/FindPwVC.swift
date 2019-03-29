//
//  FindPwVC.swift
//  CatDoor
//
//  Created by Minyoung Kim on 1/30/19.
//  Copyright © 2019 Samantha Hott. All rights reserved.
//

import UIKit
import Firebase

class FindPwVC: UIViewController {
    
    
    @IBOutlet weak var find_EmailTF: UITextField!
    @IBOutlet weak var find_ResetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        find_ResetButton.layer.cornerRadius = 10.0
        find_ResetButton.layer.masksToBounds = true
        
    }
    
    // Hide Navigation Bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    
    // reset button action
    @IBAction func ResetButtonTapped(_ sender: Any) {
        guard let email = find_EmailTF.text,
        email != ""
        else {
            AlertController.showAlert(self, title: "Missing Info", message: "Please fill out your email.")
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error == nil {
                let resetEmailAlertSent = UIAlertController(title: "Reset Email Sent", message: "Reset email has been sent to your login email. Please check your email.", preferredStyle: .alert)
                resetEmailAlertSent.addAction(UIAlertAction(title: "OK", style: .default, handler: self.sub))
                self.present(resetEmailAlertSent, animated: true, completion: nil)
            } else {
                AlertController.showAlert(self, title: "Error", message: error!.localizedDescription)
                return
            }
        }
    }
    // go back to login screen
    func sub(alert: UIAlertAction!) {
        self.performSegue(withIdentifier: "FindPwToLogin", sender: nil)
    }
    
    
}
