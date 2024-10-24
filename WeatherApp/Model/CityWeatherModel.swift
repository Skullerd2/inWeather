import Foundation

struct CityWeatherModel{
    var cityName: String
    var temp: Double
    var feelsLike: Double
    var weatherCode: Int
    var humiditiy: Int
    var windSpeed: Double
    
    init(cityName: String, temp: Double, feelsLike: Double, weather: Int, humiditiy: Int, windSpeed: Double) {
        self.cityName = cityName
        self.temp = temp
        self.feelsLike = feelsLike
        self.weatherCode = weather
        self.humiditiy = humiditiy
        self.windSpeed = windSpeed
    }
}
