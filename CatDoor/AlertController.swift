//
//  RegisterAlertController.swift
//  CatDoor
//
//  Created by Minyoung Kim on 1/23/19.
//  Copyright © 2019 Samantha Hott. All rights reserved.
//

import UIKit

class AlertController {
    static func showAlert(_ inViewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        inViewController.present(alert, animated: true, completion: nil)
    }
}
