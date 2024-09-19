//
//  CityWeatherTableViewController.swift
//  WeatherApp
//
//  Created by Vadim on 28.08.2024.
//

import UIKit

class CityWeatherTableViewController: UITableViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
}
