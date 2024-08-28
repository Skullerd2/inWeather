//
//  CityListTableViewController.swift
//  WeatherApp
//
//  Created by Vadim on 28.08.2024.
//

import UIKit

class CityListTableViewController: UITableViewController {
    
    private var city = [CityWeather]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        city = [CityWeather.example]
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return city.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as? CityTableViewCell else { return UITableViewCell() }
        cell.configure(with: city[indexPath.row])
        return cell
    }
    
}
