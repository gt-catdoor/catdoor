//
//  ViewController.swift
//  CatDoor
//
//  Created by Samantha Hott on 11/12/18.
//  Copyright © 2018 Samantha Hott. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var doorStateText:String = "Lets Cats in Only"
    @IBOutlet weak var doorState: UILabel!
    
    
    @IBAction func controlDoorButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doorState.text = doorStateText
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is ControlDoor
        {
            let vc = segue.destination as? ControlDoor
            vc?.doorText = doorStateText
        }
    }

}

