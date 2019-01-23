//
//  RegisterVC.swift
//  CatDoor
//
//  Created by Minyoung Kim on 1/20/19.
//  Copyright © 2019 Samantha Hott. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    
    @IBOutlet weak var Register_SubmitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Register_SubmitButton.layer.cornerRadius = 10.0
        Register_SubmitButton.layer.masksToBounds = true
        
        
        
    }

}
