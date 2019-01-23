//
//  LoginVC.swift
//  CatDoor
//
//  Created by Minyoung Kim on 1/20/19.
//  Copyright © 2019 Samantha Hott. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var Login_LoginButton: UIButton!
    @IBOutlet weak var Login_RegisterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Login_LoginButton.layer.cornerRadius = 10.0
        Login_LoginButton.layer.masksToBounds = true
        
        
        
    }
}
