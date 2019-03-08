//
//  ViewController.swift
//  CatDoor
//
//  Created by Samantha Hott on 11/12/18.
//  Copyright © 2018 Samantha Hott. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class HomeVC: UIViewController {

    @IBOutlet weak var Home_nameLabel: UILabel!
    var doorStateText:String = "Not Set"
    @IBOutlet weak var doorState: UILabel!
    @IBOutlet weak var Home_UpdatePictureButton: UIButton!
    @IBOutlet weak var Home_Cat: UIImageView!
    @IBOutlet weak var Home_ControlButton: UIButton!
    @IBOutlet weak var Home_ScheduleButton: UIButton!
    @IBOutlet weak var Home_StatisticsButton: UIButton!
    
    //var menu_vc : MenuVC!
    var selectedImage: UIImage?
    let picker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doorState.text = doorStateText
        
        Home_UpdatePictureButton.layer.cornerRadius = Home_UpdatePictureButton.frame.size.width / 2
        Home_UpdatePictureButton.clipsToBounds = true
        Home_UpdatePictureButton.layer.borderColor = UIColor.black.cgColor
        Home_UpdatePictureButton.layer.borderWidth = 1
        Home_Cat.layer.cornerRadius = Home_Cat.frame.size.width / 2
        Home_Cat.clipsToBounds = true
        Home_Cat.layer.borderColor = UIColor.black.cgColor
        Home_Cat.layer.borderWidth = 1
        
        Home_ControlButton.layer.cornerRadius = 10.0
        Home_ControlButton.layer.masksToBounds = true
        Home_ScheduleButton.layer.cornerRadius = 10.0
        Home_ScheduleButton.layer.masksToBounds = true
        Home_StatisticsButton.layer.cornerRadius = 10.0
        Home_StatisticsButton.layer.masksToBounds = true
        
        guard let username = Auth.auth().currentUser?.displayName else { return }
        Home_nameLabel.text = username


        picker.delegate = self
    }
    
    

    
    // Hide Navigation Bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    // Door status text appear
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is ControlDoorVC
        {
            let vc = segue.destination as? ControlDoorVC
            vc?.doorText = doorStateText
        }
    }
    
    // profile add button action
    @IBAction func addPictureAction(_ sender: Any) {
        let alert =  UIAlertController(title: "", message: "Change Profile Photo", preferredStyle: .actionSheet)

        let library =  UIAlertAction(title: "Choose from Library", style: .default) { (action) in self.openLibrary()
        }
        let camera =  UIAlertAction(title: "Take Photo", style: .default) { (action) in
            self.openCamera()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    func openLibrary(){
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(.camera)) {
            picker.sourceType = .camera
            present(picker, animated: false, completion: nil)
        } else {
            print("Camera not available.")
        }
    }

    
    // Change Picture of Cat
    @objc func handleSelectProfileImageView() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
}


// Profile picture of cat
extension HomeVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            selectedImage = image
            Home_Cat.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}


