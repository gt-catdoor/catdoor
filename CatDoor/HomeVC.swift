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

    @IBOutlet weak var SideMenuButton: UIBarButtonItem!
    @IBOutlet weak var Home_nameLabel: UILabel!
    var doorStateText:String = ""
    @IBOutlet weak var doorState: UILabel!
    @IBOutlet weak var Home_UpdatePictureButton: UIButton!
    @IBOutlet weak var Home_Cat: UIImageView!
    @IBOutlet weak var Home_ControlButton: UIButton!
    @IBOutlet weak var Home_ScheduleButton: UIButton!
    @IBOutlet weak var Home_StatisticsButton: UIButton!
    
    var menu_vc : MenuVC!
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
        
        menu_vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuVC") as? MenuVC
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGesture))
            swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)

    }
    
    // open side menu with swipe gesture
    @objc func respondToGesture(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case UISwipeGestureRecognizer.Direction.right:
            show_menu()
        case UISwipeGestureRecognizer.Direction.left:
            close_on_swipe()
        default:
            break
        }
    }
    
    func close_on_swipe() {
        if AppDelegate.menu_bool {
            //show_menu()
        } else {
            close_menu()
        }
    }
    
    // Slide menu button tapped action
    @IBAction func sideMenuAction(_ sender: UIBarButtonItem) {
        if AppDelegate.menu_bool {
            show_menu()
        } else {
            close_menu()
        }
    }
    

    func show_menu() {
        UIView.animate(withDuration: 0.3) { ()->Void in
            self.menu_vc.view.frame = CGRect(x: 0, y:80, width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.menu_vc.view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
            self.addChild(self.menu_vc)
            self.view.addSubview(self.menu_vc.view)
            AppDelegate.menu_bool = false
        }
    }
    
    func close_menu() {
        UIView.animate(withDuration: 0.3, animations: { ()->Void in self.menu_vc.view.frame = CGRect(x:-UIScreen.main.bounds.size.width, y: 80, width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            
        }) { (finished) in
            self.menu_vc.view.removeFromSuperview()
        }
        AppDelegate.menu_bool = true
    }
    
    
    func didSelectMenuOption(menuOption: MenuOption) {
        switch menuOption {
        case .Profile:
            print("Show Profile")
        case .Setting:
            print("Show Setting")
        case .Logout:
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                performSegue(withIdentifier: "HomeToMain" , sender: nil)
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }
    }
    
    
    // Sign out button action
    @IBAction func signOutTapped(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            performSegue(withIdentifier: "HomeToMain" , sender: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
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
        let alert =  UIAlertController(title: "Change Profile Photo", message: "", preferredStyle: .actionSheet)

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


