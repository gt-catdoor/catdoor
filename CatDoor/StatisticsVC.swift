//
//  StatisticsVC.swift
//  CatDoor
//
//  Created by Samantha Hott on 4/18/19.
//  Copyright © 2019 Samantha Hott. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class StatisticsVC: UIViewController {
    
    
    @IBOutlet weak var catDetectionLabel: UILabel!
    @IBOutlet weak var intruderDetctionsLabel: UILabel!
    
    var catDetected: Bool = false
    var intruderDetected: Bool = false
    
    let db = Firestore.firestore()
    
    var numCatsDetected = 0
    var numIntrudersDetected = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db.collection("CatDoor").document("data")
            .addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                guard var data = document.data() else {
                    print("Document data was empty.")
                    return
                }
                if (data["cat_detected"] as! Bool == true && self.catDetected == false) {
                    self.catDetected = true
                    self.numCatsDetected = self.numCatsDetected + 1
                    //self.db.collection("UserInfo").document((Auth.auth().currentUser?.email)!).updateData(["numberCatsDetected": self.numCatsDetected])
                } else if (data["cat_detected"] as! Bool == false && self.catDetected == true) {
                    self.catDetected = false
                }
                if (data["intruder_detected"] as! Bool == true && self.intruderDetected == false) {
                    self.intruderDetected = true
                    self.numIntrudersDetected = self.numIntrudersDetected + 1
                    //self.db.collection("UserInfo").document((Auth.auth().currentUser?.email)!).updateData(["numberIntrudersDetected": self.numIntrudersDetected])
                } else if (data["intruder_detected"] as! Bool == false && self.intruderDetected == true) {
                    self.intruderDetected = false
                }
                let numCatsString: String = String(self.numCatsDetected)
                self.catDetectionLabel.text = numCatsString
                self.intruderDetctionsLabel.text = String(self.numIntrudersDetected)
                //self.db.collection("UserInfo").document((Auth.auth().currentUser?.email)!).updateData(["numberCatsDetected": self.numCatsDetected, "numberIntrudersDetected": self.numIntrudersDetected])
        }
        /*db.collection("UserInfo").document((Auth.auth().currentUser?.email)!).addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            guard var data = document.data() else {
                print("Document data was empty.")
                return
            }
            let numCats = data["numberCatsDetected"]
            if (numCats == nil) {
                self.numCatsDetected = 0
            } else {
                self.numCatsDetected = numCats as! Int
            }
            let numIntruders = data["numberIntrudersDetected"]
            if (numIntruders == nil) {
                self.numIntrudersDetected = 0
            } else {
                self.numIntrudersDetected = numIntruders as! Int
            }
            self.catDetectionLabel.text = String(self.numCatsDetected)
            self.intruderDetctionsLabel.text = String(self.numIntrudersDetected)
        }*/
        
    }
    
    
    @IBAction func catResetButton(_ sender: Any) {
        self.numCatsDetected = 0
        self.catDetectionLabel.text = String(self.numCatsDetected)
//self.db.collection("UserInfo").document((Auth.auth().currentUser?.email)!).updateData(["numberCatsDetected": 0])
    }
    
    
    @IBAction func intruderResetButton(_ sender: Any) {
        self.numIntrudersDetected = 0
        self.intruderDetctionsLabel.text = String(self.numIntrudersDetected)
        //self.db.collection("UserInfo").document((Auth.auth().currentUser?.email)!).updateData(["numberIntrudersDetected": 0])
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

