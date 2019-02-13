//
//  MenuVC.swift
//  CatDoor
//
//  Created by Minyoung Kim on 2/6/19.
//  Copyright © 2019 Samantha Hott. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifer = "MenuOptionCell"


class MenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var menu_tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menu_tableView.delegate = self
        menu_tableView.dataSource = self
        configureTableView()
        
    }
    
    func configureTableView() {
        menu_tableView.register(MenuTableViewCells.self, forCellReuseIdentifier: reuseIdentifer)
        menu_tableView.backgroundColor = .darkGray
        menu_tableView.separatorStyle = .none
        menu_tableView.rowHeight = 80
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as! MenuTableViewCells
        
        let menuOption = MenuOption(rawValue: indexPath.row)
        cell.descriptionLabel.text = menuOption?.description
        cell.iconImageView.image = menuOption?.image
        
        return cell
    }
    
}
