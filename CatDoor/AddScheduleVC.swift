//
//  AddScheduleVC.swift
//  CatDoor
//
//  Created by Samantha Hott on 4/12/19.
//  Copyright © 2019 Samantha Hott. All rights reserved.
//

import UIKit

class AddScheduleVC: UIViewController {
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var tempOutput: UILabel!
    
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timePicker?.datePickerMode = .time
        tempOutput.text = dateFormatter.string(from: timePicker.date)
    }
}

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

