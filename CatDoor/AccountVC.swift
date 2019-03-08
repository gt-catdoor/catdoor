//
//  AccountVC.swift
//  CatDoor
//
//  Created by Minyoung Kim on 2/28/19.
//  Copyright © 2019 Samantha Hott. All rights reserved.
//

import UIKit

class AccountVC: UIViewController {

    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitButton.layer.cornerRadius = 10.0
        submitButton.layer.masksToBounds = true

        // Do any additional setup after loading the view.
    }
    

   
}
