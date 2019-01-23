//
//  MainVC.swift
//  CatDoor
//
//  Created by Minyoung Kim on 1/20/19.
//  Copyright © 2019 Samantha Hott. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var Main_LoginButton: UIButton!
    @IBOutlet weak var Main_RegisterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Main_LoginButton.layer.cornerRadius = 10.0
        Main_LoginButton.layer.masksToBounds = true
        Main_RegisterButton.layer.cornerRadius = 10.0
        Main_RegisterButton.layer.masksToBounds = true
        
        
        
    }

}
