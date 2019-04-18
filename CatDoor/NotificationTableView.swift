//
//  NotificationTableView.swift
//  CatDoor
//
//  Created by Minyoung Kim on 3/5/19.
//  Copyright © 2019 Samantha Hott. All rights reserved.
//

import UIKit
import UserNotifications
import FirebaseFirestore
import Firebase

class NotificationTableView: UITableViewController {
    let db = Firestore.firestore()
    
    
    @IBAction func cat_switch(_ sender: UISwitch) {
        if (sender.isOn == true) {
            
        } else {
            
        }
        
    }
    @IBAction func intruder_switch(_ sender: UISwitch) {
        if (sender.isOn == true) {
            
        } else {
            
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Ask for permrssion
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound]) {
            (granted, error) in
        }
        
        // Create the notification content
        let content = UNMutableNotificationContent()
        content.title = "Notification title"
        content.body = "Notification body"
        

        // received data from firestore
        db.collection("CatDoor").document("data")
            .addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                print("\(document.data())")
        }
        

    }
    
    

    
    
    

}
