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
    @IBOutlet weak var deleteButton: UIButton!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.HideKeyboard()
        username_TF.delegate = self
        phone_TF.delegate = self

        submitButton.layer.cornerRadius = 10.0
        submitButton.layer.masksToBounds = true
        deleteButton.layer.cornerRadius = 10.0
        deleteButton.layer.masksToBounds = true
        
        
        guard Auth.auth().currentUser != nil else {
            return
        }

        // Do any additional setup after loading the view.
    }
    
    
    // delete button action. popup manu pops
    @IBAction func delete_Tapped(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure?", message: "", preferredStyle: .alert )
        let okAction = UIAlertAction(title: "OK", style: .default, handler:self.toMain)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
   
    
    // delete account and go to main screen
    func toMain(alert: UIAlertAction!) {
        
        let user = Auth.auth().currentUser
        
        user?.delete { error in
            if let error = error {
                // An error happened.
                AlertController.showAlert(self, title: "Error", message: error.localizedDescription)
                return
            } else {
                // Account deleted.
                //self.db.collection("UserInfo").document().delete()
                
                self.performSegue(withIdentifier: "accountToMain", sender: nil)
            }
        }
    }
    
    
    // submit button action. edit user information
    @IBAction func submit_Tapped(_ sender: Any) {
        
        guard
            let username = username_TF.text,
            username != "",
            let phone = phone_TF.text,
            phone != ""
            else {
                AlertController.showAlert(self, title: "Error!", message: "Please check your information.")
                return
        }
        
        self.db.collection("UserInfo").document((Auth.auth().currentUser?.email)!).updateData(["username":self.username_TF.text, "phone":self.phone_TF.text])
        
        
//        db.collection("UserInfo").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//
//            } else {
//
//                for document in querySnapshot!.documents {
//                    self.db.collection("UserInfo").document((Auth.auth().currentUser?.email)!).updateData(["username":self.username_TF.text, "phone":self.phone_TF.text])
//                    { err in
//                        if let err = err {
//
//                            print("Error updating document: \(err)")
//                        } else {
//                            print("Document successfully updated")
//                            self.performSegue(withIdentifier: "AccountToSetting", sender: nil)
//                        }
//                    }
//                }
//            }
//        }
    }
}
