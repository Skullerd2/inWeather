import Foundation

struct CityWeatherModel{
    var cityName: String
    var temp: Double
    var feelsLike: Double
    var weather: String
    var humiditiy: Int
    var windSpeed: Double
    var rain: Double?
    var snow: Double?
    
    init(cityName: String, temp: Double, feelsLike: Double, weather: String, humiditiy: Int, windSpeed: Double, rain: Double? = nil, snow: Double? = nil) {
        self.cityName = cityName
        self.temp = temp
        self.feelsLike = feelsLike
        self.weather = weather
        self.humiditiy = humiditiy
        self.windSpeed = windSpeed
        self.rain = rain
        self.snow = snow
    }
}
