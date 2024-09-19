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
    
//    func configure(with weatherModel: WeatherModel){
//        cityNameLabel.text = weatherModel.name
//        weatherImage.image = weatherModel.weather
//        tempLabel.text = String(weatherModel.temp)
//    }

}
