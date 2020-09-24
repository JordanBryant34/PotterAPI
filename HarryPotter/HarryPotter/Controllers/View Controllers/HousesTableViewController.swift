//
//  HousesTableViewController.swift
//  HarryPotter
//
//  Created by Jordan Bryant on 9/23/20.
//  Copyright © 2020 Jordan Bryant. All rights reserved.
//

import UIKit

class HousesTableViewController: UITableViewController {
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        ai.style = .large
        ai.center = self.view.center
        return ai
    }()
    
    var houses: [House] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        getHouses()
        setupActivityIndicator()
    }
    
    private func getHouses() {
        HouseController.getHouses { (result) in
            switch result {
            case .success(let houses):
                self.houses = houses
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return houses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "houseCellId") as? HouseTableViewCell else { return UITableViewCell(frame: .zero) }
        let house = houses[indexPath.row]
        
        cell.house = house
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let detailVC = segue.destination as? HouseDetailTableViewController else { return }
            guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
            
            let house = houses[selectedIndexPath.row]
            detailVC.house = house
        }
    }
}
