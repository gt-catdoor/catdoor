//
//  ScheduleVC.swift
//  CatDoor
//
//  Created by Samantha Hott on 4/10/19.
//  Copyright © 2019 Samantha Hott. All rights reserved.
//

import UIKit

class ScheduleVC: UIViewController {
    

    
    @IBOutlet weak var tableView: UITableView!
    
    var times: [String] = ["1:25 PM", "5:30 AM", "10:30 PM", "11:00 AM"]
    var dates: [String] = ["APR 04 THU", "REPEATING", "REPEATING", "APR 05 FRI"]
    var states: [String] = ["UNLOCK", "LOCK DOWN", "IN ONLY", "OUT ONLY"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ScheduleVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return times.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let time = times[indexPath.row]
        let date = dates[indexPath.row]
        let state = states[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmCell") as! AlarmCell
        cell.setSchedule(time: time, date: date, state: state)
        return cell
    }
}
