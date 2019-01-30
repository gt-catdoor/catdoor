//
//  RegisterVC.swift
//  CatDoor
//
//  Created by Minyoung Kim on 1/20/19.
//  Copyright © 2019 Samantha Hott. All rights reserved.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {
    
    @IBOutlet weak var Register_UsernameTF: UITextField!
    @IBOutlet weak var Register_PwTF: UITextField!
    @IBOutlet weak var Register_PwCheckTF: UITextField!
    @IBOutlet weak var Register_CatTF: UITextField!
    @IBOutlet weak var Register_EmailTF: UITextField!
    @IBOutlet weak var Register_PhoneTF: UITextField!
    @IBOutlet weak var Register_SubmitButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Register_SubmitButton.layer.cornerRadius = 10.0
        Register_SubmitButton.layer.masksToBounds = true
    }
    
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        guard let username = Register_UsernameTF.text,
            username != "",
            let password = Register_PwTF.text,
            password != "",
            let passwordConfirm = Register_PwCheckTF.text,
            passwordConfirm == password,
            let email = Register_EmailTF.text,
            email != ""
            else {
                AlertController.showAlert(self, title: "Error!", message: "Please check your information.")
                return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            guard error == nil else {
                AlertController.showAlert(self, title: "Error", message: error!.localizedDescription)
                return
            }
            
            guard let user = authResult?.user else { return }
            
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = username
            changeRequest.commitChanges(completion: {(error) in
                guard error == nil else {
                    AlertController.showAlert(self, title: "Error", message: error!.localizedDescription)
                    return
                }
                
                self.performSegue(withIdentifier: "RegisterToLogin", sender: nil)
            })
        }
    }
}
