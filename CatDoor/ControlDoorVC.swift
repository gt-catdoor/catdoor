//
//  ControlDoor.swift
//  CatDoor
//
//  Created by Samantha Hott on 11/12/18.
//  Copyright © 2018 Samantha Hott. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ControlDoorVC: UIViewController {
    //FirebaseApp.configure()
    var ref: DatabaseReference!
    @IBOutlet weak var unlockButton: UIButton!
    @IBOutlet weak var lockDownButton: UIButton!
    @IBOutlet weak var inOnlyButton: UIButton!
    @IBOutlet weak var outOnlyButton: UIButton!
    
    var doorText:String = ""
    
    @IBAction func unlockButton(_ sender: UIButton) {
        unlockButton.isSelected = true
        doorText = "Unlocked"
        lockDownButton.isSelected = false
        inOnlyButton.isSelected = false
        outOnlyButton.isSelected = false
        ref.child("CatDoor").setValue(["doorstatus":"unlocked"])
        
        //Popup
        let alert = UIAlertController(title: "Are you sure?", message: "", preferredStyle: .alert )
        let okAction = UIAlertAction(title: "OK", style: .default, handler: self.sub)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:  nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func lockDownButton(_ sender: Any) {
        lockDownButton.isSelected = true
        doorText = "Locked down"
        unlockButton.isSelected = false
        inOnlyButton.isSelected = false
        outOnlyButton.isSelected = false
        
        //Popup
        let alert = UIAlertController(title: "Are you sure?", message: "", preferredStyle: .alert )
        let okAction = UIAlertAction(title: "OK", style: .default, handler: self.sub)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:  nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    @IBAction func inOnlyButton(_ sender: Any) {
        inOnlyButton.isSelected = true
        doorText = "Lets Cats in Only"
        unlockButton.isSelected = false
        lockDownButton.isSelected = false
        outOnlyButton.isSelected = false
        
        //Popup
        let alert = UIAlertController(title: "Are you sure?", message: "", preferredStyle: .alert )
        let okAction = UIAlertAction(title: "OK", style: .default, handler: self.sub)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:  nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    @IBAction func outOnlyButton(_ sender: Any) {
        outOnlyButton.isSelected = true
        doorText = "Lets Cats out Only"
        unlockButton.isSelected = false
        lockDownButton.isSelected = false
        inOnlyButton.isSelected = false
        
        //Popup
        let alert = UIAlertController(title: "Are you sure?", message: "", preferredStyle: .alert )
        let okAction = UIAlertAction(title: "OK", style: .default, handler: self.sub)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:  nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func backButton(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        if (doorText == "Lets Cats out Only") {
            unlockButton.isSelected = false
            lockDownButton.isSelected = false
            inOnlyButton.isSelected = false
            outOnlyButton.isSelected = true
        } else if (doorText == "Locked down") {
            lockDownButton.isSelected = true
            unlockButton.isSelected = false
            inOnlyButton.isSelected = false
            outOnlyButton.isSelected = false
        } else if (doorText == "Lets Cats in Only") {
            inOnlyButton.isSelected = true
            unlockButton.isSelected = false
            lockDownButton.isSelected = false
            outOnlyButton.isSelected = false
        } else {
            outOnlyButton.isSelected = false
            unlockButton.isSelected = true
            lockDownButton.isSelected = false
            inOnlyButton.isSelected = false
        }
    }
    
    // Hide Navigation Bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is HomeVC
        {
            let vc = segue.destination as? HomeVC
            vc?.doorStateText = doorText
        }
    }
    
     //If pressed OK, then go to home screen.
    func sub(alert: UIAlertAction!) {
        self.performSegue(withIdentifier: "ToHome", sender: nil)
    }
}
