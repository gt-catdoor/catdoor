//
//  DayCell.swift
//  CatDoor
//
//  Created by Samantha Hott on 4/15/19.
//  Copyright © 2019 Samantha Hott. All rights reserved.
//

import UIKit

class DayCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    
    func setDay(day: String) {
        dayLabel.text = day
    }
    
    func returnDay() ->String {
        return dayLabel.text ?? ""
    }

}
