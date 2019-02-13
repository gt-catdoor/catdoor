//
//  MenuOption.swift
//  CatDoor
//
//  Created by Minyoung Kim on 2/11/19.
//  Copyright © 2019 Samantha Hott. All rights reserved.
//

import UIKit

enum MenuOption: Int, CustomStringConvertible {
    
    case Profile
    case Setting
    case Logout
    
    var description: String {
        switch  self {
        case .Profile: return "Profile"
        case .Setting: return "Setting"
        case .Logout: return "Logout"
        }
    
    }
    var image: UIImage {
        switch  self {
        case .Profile: return UIImage(named: "Profile_White") ?? UIImage()
        case .Setting: return UIImage(named: "Setting_White") ?? UIImage()
        case .Logout: return UIImage(named: "Logout_White") ?? UIImage()
        }
    }
    
}
