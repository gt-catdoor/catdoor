//
//  AlarmCell.swift
//  CatDoor
//
//  Created by Samantha Hott on 4/10/19.
//  Copyright © 2019 Samantha Hott. All rights reserved.
//

import UIKit

class AlarmCell: UITableViewCell {
    
    @IBOutlet weak var timeDisplay: UILabel!
    @IBOutlet weak var dateSettingDisplay: UILabel!
    @IBOutlet weak var stateDisplay: UILabel!
    
    

func setSchedule(time: String, date: String, state: String) {
        timeDisplay.text = time
        dateSettingDisplay.text = date
        stateDisplay.text = state
    }
}
