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
    
    var numCatsDetected = 0
    var numIntrudersDetected = 0
    
    let db = Firestore.firestore()
    
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
                    //self.catDetectionLabel.text = String(self.numCatsDetected)
                } else if (data["cat_detected"] as! Bool == false && self.catDetected == true) {
                    self.catDetected = false
                }
                if (data["intruder_detected"] as! Bool == true && self.intruderDetected == false) {
                    self.intruderDetected = true
                    self.numIntrudersDetected = self.numIntrudersDetected + 1
                    //self.intruderDetctionsLabel.text = String(self.numIntrudersDetected)
                } else if (data["intruder_detected"] as! Bool == false && self.intruderDetected == true) {
                    self.intruderDetected = false
                }
                print("catDetections: " + String(self.numCatsDetected))
                print("intruderDetections: " + String(self.numIntrudersDetected))
                self.catDetectionLabel.text = String(self.numCatsDetected)
                self.intruderDetctionsLabel.text = String(self.numIntrudersDetected)
        }
        
    }
    
    
    @IBAction func catResetButton(_ sender: Any) {
        self.numCatsDetected = 0
        self.catDetectionLabel.text = String(self.numCatsDetected)
    }
    
    
    @IBAction func intruderResetButton(_ sender: Any) {
        self.numIntrudersDetected = 0
        self.intruderDetctionsLabel.text = String(self.numIntrudersDetected)
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

