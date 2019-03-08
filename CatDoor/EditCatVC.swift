//
//  EditCatVC.swift
//  CatDoor
//
//  Created by Minyoung Kim on 3/7/19.
//  Copyright © 2019 Samantha Hott. All rights reserved.
//

import UIKit

class EditCatVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    var number = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    var picker = UIPickerView()
    var selectedNumber : String?
    
    @IBOutlet weak var catNumLabel: UILabel!
    @IBOutlet weak var catNumTF: UITextField!
    @IBOutlet weak var submitBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitBTN.layer.cornerRadius = 10.0
        submitBTN.layer.masksToBounds = true
        
        createPickerView()
        dissmissPickerView()

        // Do any additional setup after loading the view.
    }
    
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
        catNumTF.text = selectedNumber
        catNumLabel.text = selectedNumber
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        catNumTF.inputView = pickerView
    }
    
    func dissmissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dissmissKeyboard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        catNumTF.inputAccessoryView = toolBar
    }
    
    @objc func dissmissKeyboard() {
        view.endEditing(true)
    }

}
