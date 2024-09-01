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
    var temp: Int
    
    static let example = CityWeather(name: "St. Petersburg")
    
    init(name: String){
        self.name = name
        weather = UIImage(systemName: "sun.max.fill")!
        temp = 15
    }
}

