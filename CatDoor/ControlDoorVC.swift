//
//  ControlDoor.swift
//  CatDoor
//
//  Created by Samantha Hott on 11/12/18.
//  Copyright © 2018 Samantha Hott. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class ControlDoorVC: UIViewController {
    let db = Firestore.firestore()
    @IBOutlet weak var unlockButton: UIButton!
    @IBOutlet weak var lockDownButton: UIButton!
    @IBOutlet weak var inOnlyButton: UIButton!
    @IBOutlet weak var outOnlyButton: UIButton!
    
    var doorText:String = ""
    
    
    
    // unlock button action
    @IBAction func unlockButton(_ sender: UIButton) {
        unlockButton.isSelected = true
        lockDownButton.isSelected = false
        inOnlyButton.isSelected = false
        outOnlyButton.isSelected = false
        //Popup
        let alert = UIAlertController(title: "Are you sure?", message: "", preferredStyle: .alert )
        let okAction = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) -> Void in
            self.doorText = "Unlock"
            self.db.collection("CatDoor").document("data").updateData(["doorstatus":"Unlock"])
            self.db.collection("UserInfo").document((Auth.auth().currentUser?.email)!).updateData(["doorstatus":"Unlock"])
            self.performSegue(withIdentifier: "controlToHome", sender: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:  nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    // lock button action
    @IBAction func lockDownButton(_ sender: Any) {
        lockDownButton.isSelected = true
        unlockButton.isSelected = false
        inOnlyButton.isSelected = false
        outOnlyButton.isSelected = false
        
        //Popup
        let alert = UIAlertController(title: "Are you sure?", message: "", preferredStyle: .alert )
        let okAction = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) -> Void in
            self.doorText = "Lock Down"
            self.db.collection("CatDoor").document("data").updateData(["doorstatus":"Lock Down"])
            self.db.collection("UserInfo").document((Auth.auth().currentUser?.email)!).updateData(["doorstatus":"Lock Down"])
            self.performSegue(withIdentifier: "controlToHome", sender: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:  nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    // in only button action
    @IBAction func inOnlyButton(_ sender: Any) {
        inOnlyButton.isSelected = true
        unlockButton.isSelected = false
        lockDownButton.isSelected = false
        outOnlyButton.isSelected = false
        
        //Popup
        let alert = UIAlertController(title: "Are you sure?", message: "", preferredStyle: .alert )
        let okAction = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) -> Void in
            self.doorText = "Let Cats in Only"
            self.db.collection("CatDoor").document("data").updateData(["doorstatus":"Let Cats in Only"])
            self.db.collection("UserInfo").document((Auth.auth().currentUser?.email)!).updateData(["doorstatus":"Let Cats in Only"])
            self.performSegue(withIdentifier: "controlToHome", sender: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:  nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    //out only button action
    @IBAction func outOnlyButton(_ sender: Any) {
        outOnlyButton.isSelected = true
        unlockButton.isSelected = false
        lockDownButton.isSelected = false
        inOnlyButton.isSelected = false
        //Popup
        let alert = UIAlertController(title: "Are you sure?", message: "", preferredStyle: .alert )
        let okAction = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) -> Void in
            self.doorText = "Let Cats out Only"
            self.db.collection("CatDoor").document("data").updateData(["doorstatus":"Let Cats out Only"])
            self.db.collection("UserInfo").document((Auth.auth().currentUser?.email)!).updateData(["doorstatus":"Let Cats out Only"])
            self.performSegue(withIdentifier: "controlToHome", sender: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:  nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        if (doorText == "Let Cats out Only") {
            unlockButton.isSelected = false
            lockDownButton.isSelected = false
            inOnlyButton.isSelected = false
            outOnlyButton.isSelected = true
        } else if (doorText == "Lock Down") {
            lockDownButton.isSelected = true
            unlockButton.isSelected = false
            inOnlyButton.isSelected = false
            outOnlyButton.isSelected = false
        } else if (doorText == "Let Cats in Only") {
            inOnlyButton.isSelected = true
            unlockButton.isSelected = false
            lockDownButton.isSelected = false
            outOnlyButton.isSelected = false
        } else if (doorText == "Unlock") {
            outOnlyButton.isSelected = false
            unlockButton.isSelected = true
            lockDownButton.isSelected = false
            inOnlyButton.isSelected = false
        } else {
            outOnlyButton.isSelected = false
            unlockButton.isSelected = false
            lockDownButton.isSelected = false
            inOnlyButton.isSelected = false
        }
    }
    
    // Hide Navigation Bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    // door status messege from home screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is HomeVC
        {
            let vc = segue.destination as? HomeVC
            vc?.doorStateText = doorText
        }
    }
    
     //If pressed OK, then go to home screen.
//    func sub(alert: UIAlertAction!) {
//        self.performSegue(withIdentifier: "controlToHome", sender: nil)
//    }
}
