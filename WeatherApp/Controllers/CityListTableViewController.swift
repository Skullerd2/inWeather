//
//  CityListTableViewController.swift
//  WeatherApp
//
//  Created by Vadim on 28.08.2024.
//

import UIKit

class CityListTableViewController: UITableViewController {
    
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCurrentLocation()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    

    private func fetchCurrentLocation(){
        networkManager.fetchCurrentWeather(lat: 31.229421, lon: 121.476303) { [weak self] result in
            switch result{
            case .success(let weather):
                print("Weather is fetched")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}
