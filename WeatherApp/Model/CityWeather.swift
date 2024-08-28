//
//  CityModel.swift
//  WeatherApp
//
//  Created by Vadim on 28.08.2024.
//

import Foundation
import UIKit

struct CityWeather{
    var name: String
    var weather: UIImage
    var temp: String
    
    static let example = CityWeather(name: "St. Petersburg", weather: UIImage(systemName: "sun.max.fill")!, temp: "15°")
    
    init(name: String, weather: UIImage, temp: String) {
        self.name = name
        self.weather = weather
        self.temp = temp
    }
}

