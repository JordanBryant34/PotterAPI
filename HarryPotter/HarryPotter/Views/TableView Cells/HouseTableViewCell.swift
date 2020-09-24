//
//  HouseTableViewCell.swift
//  HarryPotter
//
//  Created by Jordan Bryant on 9/23/20.
//  Copyright © 2020 Jordan Bryant. All rights reserved.
//

import UIKit

class HouseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var houseImageView: UIImageView!
    @IBOutlet weak var houseNameLabel: UILabel!
    @IBOutlet weak var houseMembersLabel: UILabel!
    
    var house: House? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        houseMembersLabel.text = "\(house?.members.count ?? 0) members"
        
        if let name = house?.name {
            houseImageView.image = UIImage(named: name)
            houseNameLabel.text = name
        }
        
        accessoryType = .disclosureIndicator
    }
}
