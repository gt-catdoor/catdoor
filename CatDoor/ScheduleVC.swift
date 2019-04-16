//
//  ScheduleVC.swift
//  CatDoor
//
//  Created by Samantha Hott on 4/10/19.
//  Copyright © 2019 Samantha Hott. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class ScheduleVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let db = Firestore.firestore()
    
    var schedules: [Schedule] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let docRef = self.db.collection("UserInfo").document((Auth.auth().currentUser?.email)!).collection("Schedules").document("NumOfSchedules")
        
        var numSchedules:Int? = 0
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                numSchedules = document.get("Total") as! Int
                for x in 1...numSchedules! {
                    let scheduleName = "Schedule" + String(x)
                    let scheduleRef = self.db.collection("UserInfo").document((Auth.auth().currentUser?.email)!).collection("Schedules").document(scheduleName)
                    scheduleRef.getDocument { (document, error) in
                        if let document = document, document.exists {
                            let scheduleTime = document.get("time") as! String
                            let scheduleDate = document.get("date") as! String
                            let scheduleState = document.get("state") as! String
                            let schedule = Schedule(time: scheduleTime, date: scheduleDate, state: scheduleState)
                            self.schedules.append(schedule)
                            self.tableView.reloadData()
                        } else {
                        }
                    }
                }
            }
        }
    }
}

extension ScheduleVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedules.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let schedule = schedules[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmCell") as! AlarmCell
        cell.setSchedule(schedule: schedule)
        return cell
    }
}
