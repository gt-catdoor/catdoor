//
//  Schedule.swift
//  CatDoor
//
//  Created by Samantha Hott on 4/15/19.
//  Copyright © 2019 Samantha Hott. All rights reserved.
//

import Foundation

class Schedule {
    var time: String
    var date: String
    var state: String
    
    init(time: String, date: String, state: String) {
        self.time = time
        self.date = date
        self.state = state
    }
}
