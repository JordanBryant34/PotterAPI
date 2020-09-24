//
//  HouseDetailTableViewController.swift
//  HarryPotter
//
//  Created by Jordan Bryant on 9/24/20.
//  Copyright © 2020 Jordan Bryant. All rights reserved.
//

import UIKit

class HouseDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var houseImageView: UIImageView!
    @IBOutlet weak var houseNameLabel: UILabel!
    @IBOutlet weak var houseFounderLabel: UILabel!
    @IBOutlet weak var headOfHouseLabel: UILabel!
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        ai.style = .large
        ai.center = self.view.center
        return ai
    }()
    
    var house: House?
    var members: [Member] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        updateViews()
        getMembers()
    }
    
    private func updateViews() {
        guard let house = house else { return }
        
        title = house.name
        houseNameLabel.text = house.name
        houseImageView.image = UIImage(named: house.name)
        
        houseFounderLabel.text = "Founder: \(house.founder)"
        headOfHouseLabel.text = "Head: \(house.headOfHouse)"
        
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func getMembers() {
        guard let house = house else { return }
        MemberController.getMembersOfHouse(from: house) { (members) in
            self.members = members
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCellId")!
        let member = members[indexPath.row]
        
        cell.textLabel?.text = member.name
        cell.detailTextLabel?.text = "Occupation: \(member.role?.capitalized ?? "N/A")"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
}
