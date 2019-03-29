//
//  LoginVC.swift
//  CatDoor
//
//  Created by Minyoung Kim on 1/20/19.
//  Copyright © 2019 Samantha Hott. All rights reserved.
//

import UIKit
import Firebase


class LoginVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var Login_LoginButton: UIButton!
    @IBOutlet weak var Login_RegisterButton: UIButton!
    @IBOutlet weak var Login_emailTF: UITextField!
    @IBOutlet weak var Login_pwTF: UITextField!
    @IBOutlet weak var ScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Login_LoginButton.layer.cornerRadius = 10.0
        Login_LoginButton.layer.masksToBounds = true
        Login_pwTF.delegate = self
        Login_emailTF.delegate = self
        
        self.HideKeyboard()
        
    }
    
    // Hide Navigation Bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    @IBAction func onLoginTapped(_ sender: Any) {
        guard let email = Login_emailTF.text,
        email != "",
        let password = Login_pwTF.text,
        password != ""
            else {
                AlertController.showAlert(self, title: "Missing Info", message: "Please fill out all information.")
                return
        }
    
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil {
                self.performSegue(withIdentifier: "LoginToHome", sender: nil)
            } else {
                AlertController.showAlert(self, title: "Error", message: error!.localizedDescription)
                return
                
            }            
        }
    }
}

//Hide Keyboard
extension UIViewController {
    func HideKeyboard() {
        let Tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        view.addGestureRecognizer(Tap)
    }
    @objc func DismissKeyboard() {
        view.endEditing(true)
    }
}


