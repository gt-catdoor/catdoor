//
//  ViewController.swift
//  CatDoor
//
//  Created by Samantha Hott on 11/12/18.
//  Copyright © 2018 Samantha Hott. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    var doorStateText:String = ""
    @IBOutlet weak var doorState: UILabel!
    @IBOutlet weak var Home_Cat: UIImageView!
    @IBOutlet weak var Home_ControlButton: UIButton!
    @IBOutlet weak var Home_ScheduleButton: UIButton!
    @IBOutlet weak var Home_StatisticsButton: UIButton!
    
    
    @IBAction func controlDoorButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doorState.text = doorStateText
        
        Home_Cat.layer.cornerRadius = Home_Cat.frame.size.width / 2
        Home_Cat.clipsToBounds = true
        Home_Cat.layer.borderColor = UIColor.black.cgColor
        Home_Cat.layer.borderWidth = 1
        Home_ControlButton.layer.cornerRadius = 10.0
        Home_ControlButton.layer.masksToBounds = true
        Home_ScheduleButton.layer.cornerRadius = 10.0
        Home_ScheduleButton.layer.masksToBounds = true
        Home_StatisticsButton.layer.cornerRadius = 10.0
        Home_StatisticsButton.layer.masksToBounds = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is ControlDoorVC
        {
            let vc = segue.destination as? ControlDoorVC
            vc?.doorText = doorStateText
        }
    }

}

