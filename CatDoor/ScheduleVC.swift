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
    
    var schedules: [Schedule] = [Schedule(time: "1:25 PM", date: "Every Monday, Every Tuesday, Every Friday", state: "UNLOCK"), Schedule(time: "10:30 PM", date: "Every Monday, Every Saturday, Every Sunday", state: "Let Cats in Only")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
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
