//
//  SettingTableView.swift
//  CatDoor
//
//  Created by Minyoung Kim on 2/28/19.
//  Copyright © 2019 Samantha Hott. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SettingTableView: UITableViewController {
    @IBOutlet weak var setting_logout: UITableViewCell!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    // logout button action.
    @IBAction func setting_logout(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            performSegue(withIdentifier: "settingToMain" , sender: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    
}
