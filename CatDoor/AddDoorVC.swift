//
//  AddDoorVC.swift
//  CatDoor
//
//  Created by Minyoung Kim on 3/5/19.
//  Copyright © 2019 Samantha Hott. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore


class AddDoorVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    let db = Firestore.firestore()

    var number = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    var picker = UIPickerView()
    var selectedNumber : String?
    
    @IBOutlet weak var addDoorTF: UITextField!
    @IBOutlet weak var submitBTN: UIButton!
    @IBOutlet weak var numOfDoor: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createPickerView()
        dissmissPickerView()
        
        submitBTN.layer.cornerRadius = 10.0
        submitBTN.layer.masksToBounds = true
        
        
        
        db.collection("UserInfo").whereField("email", isEqualTo: (Auth.auth().currentUser?.email)!).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print(err)
            } else {
                for document in querySnapshot!.documents {
                    let numOfdoor = document.data()["numberOfdoor"] as? String
                    self.numOfDoor.text = numOfdoor
                }
            }
        }
    }
    
    
    
    
    
    // Picker View
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return number.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return number[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedNumber = number[row]
        addDoorTF.text = selectedNumber
        numOfDoor.text = selectedNumber
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        addDoorTF.inputView = pickerView
    }
    
    func dissmissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dissmissKeyboard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        addDoorTF.inputAccessoryView = toolBar
    }
    
    @objc func dissmissKeyboard() {
        view.endEditing(true)
    }
    
    
    @IBAction func submit_Tapped(_ sender: Any) {
        self.db.collection("UserInfo").document((Auth.auth().currentUser?.email)!).updateData(["numberOfdoor":self.addDoorTF.text])
        self.performSegue(withIdentifier: "EditDoorToSetting", sender: nil)
    }
}
