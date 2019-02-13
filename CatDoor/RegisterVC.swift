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
    @IBOutlet weak var Register_AddDoor: UILabel!
    @IBOutlet weak var Register_NumOfDoor: UILabel!

    var addDoorStr: String? = ""
    var numOfDoorStr: String? = ""

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Register_SubmitButton.layer.cornerRadius = 10.0
        Register_SubmitButton.layer.masksToBounds = true
        Register_AddDoor.text = addDoorStr
        Register_NumOfDoor.text = numOfDoorStr
    }
    
    //Add door button action
    @IBAction func addDoorTapped(_ sender: Any) {
        let alertCT = UIAlertController(title: "Please add your door.", message:nil, preferredStyle: .alert)
        alertCT.addTextField { (door: UITextField!) -> Void in door.placeholder = "Enter your door."
        }
        let okAc = UIAlertAction(title: "OK", style: .default) { (alert: UIAlertAction!) -> Void in
            let addDoor = alertCT.textFields![0]
            self.Register_AddDoor.text = addDoor.text
            alertCT.dismiss(animated: true, completion: nil)
        }
        let cancelAc = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertCT.addAction(okAc)
        alertCT.addAction(cancelAc)
        present(alertCT, animated: true, completion: nil)
    }
    
    //number of added door action
    @IBAction func numberOfDoorTapped(_ sender: Any) {
        let alertND = UIAlertController(title: "How many number of added door?", message:nil, preferredStyle: .alert)
        alertND.addTextField { (door: UITextField!) -> Void in door.placeholder = "Enter number of door."
        }
        let okAc = UIAlertAction(title: "OK", style: .default) { (alert: UIAlertAction!) -> Void in
            let numberDoor = alertND.textFields![0]
            self.Register_NumOfDoor.text = numberDoor.text
            alertND.dismiss(animated: true, completion: nil)
        }
        let cancelAc = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertND.addAction(okAc)
        alertND.addAction(cancelAc)
        present(alertND, animated: true, completion: nil)
    }
    
    
    // Register button action
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
