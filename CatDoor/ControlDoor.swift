//
//  ControlDoor.swift
//  CatDoor
//
//  Created by Samantha Hott on 11/12/18.
//  Copyright © 2018 Samantha Hott. All rights reserved.
//

import UIKit

class ControlDoor: UIViewController {
    @IBOutlet weak var unlockButton: UIButton!
    @IBOutlet weak var lockDownButton: UIButton!
    @IBOutlet weak var inOnlyButton: UIButton!
    @IBOutlet weak var outOnlyButton: UIButton!
    
    var doorText:String = "Lets Cats in Only"
    
    @IBAction func unlockButton(_ sender: UIButton) {
        unlockButton.isSelected = true
        doorText = "Unlocked"
        lockDownButton.isSelected = false
        inOnlyButton.isSelected = false
        outOnlyButton.isSelected = false
    }
    @IBAction func lockDownButton(_ sender: Any) {
        lockDownButton.isSelected = true
        doorText = "Locked down"
        unlockButton.isSelected = false
        inOnlyButton.isSelected = false
        outOnlyButton.isSelected = false
    }
    @IBAction func inOnlyButton(_ sender: Any) {
        inOnlyButton.isSelected = true
        doorText = "Lets Cats in Only"
        unlockButton.isSelected = false
        lockDownButton.isSelected = false
        outOnlyButton.isSelected = false
    }
    @IBAction func outOnlyButton(_ sender: Any) {
        outOnlyButton.isSelected = true
        doorText = "Lets Cats out Only"
        unlockButton.isSelected = false
        lockDownButton.isSelected = false
        inOnlyButton.isSelected = false
    }
    
    @IBAction func backButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (doorText == "Unlocked") {
            unlockButton.isSelected = true
            lockDownButton.isSelected = false
            inOnlyButton.isSelected = false
            outOnlyButton.isSelected = false
        } else if (doorText == "Locked down") {
            lockDownButton.isSelected = true
            unlockButton.isSelected = false
            inOnlyButton.isSelected = false
            outOnlyButton.isSelected = false
        } else if (doorText == "Lets Cats in Only") {
            inOnlyButton.isSelected = true
            unlockButton.isSelected = false
            lockDownButton.isSelected = false
            outOnlyButton.isSelected = false
        } else {
            outOnlyButton.isSelected = true
            unlockButton.isSelected = false
            lockDownButton.isSelected = false
            inOnlyButton.isSelected = false
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is ViewController
        {
            let vc = segue.destination as? ViewController
            vc?.doorStateText = doorText
        }
    }

}
