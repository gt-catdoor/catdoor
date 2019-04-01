//
//  AccountVC.swift
//  CatDoor
//
//  Created by Minyoung Kim on 2/28/19.
//  Copyright © 2019 Samantha Hott. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore


class AccountVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var username_TF: UITextField!
    @IBOutlet weak var phone_TF: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.HideKeyboard()
        username_TF.delegate = self
        phone_TF.delegate = self

        submitButton.layer.cornerRadius = 10.0
        submitButton.layer.masksToBounds = true
        
        guard Auth.auth().currentUser != nil else {
            return
        }

        // Do any additional setup after loading the view.
    }
    
    
    // submit button action
    @IBAction func submit_Tapped(_ sender: Any) {
        
        guard let userUid = Auth.auth().currentUser?.uid else { return }

        guard
            let username = username_TF.text,
            username != "",
            let phone = phone_TF.text,
            phone != ""
            else {
                AlertController.showAlert(self, title: "Error!", message: "Please check your information.")
                return
        }
        
        db.collection("UserInfo").document(userUid).updateData(["username":self.username_TF.text,
            "phone":self.phone_TF.text])
    
        { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
                self.performSegue(withIdentifier: "AccountToSetting", sender: nil)

            }
        }
    }
}
