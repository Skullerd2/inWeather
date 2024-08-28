//
//  CityTableViewCell.swift
//  WeatherApp
//
//  Created by Vadim on 28.08.2024.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    func configure(with cityWeather: CityWeather){
        cityNameLabel.text = cityWeather.name
        weatherImage.image = cityWeather.weather
        tempLabel.text = cityWeather.temp
    }

}
