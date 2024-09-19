import Foundation

struct WeatherModel: Decodable{
    
    var weather: [WeatherData?]
    var main: MainData?
    var wind: WindData?
    var rain: RainData?
    var snow: SnowData?
    
    init(weather: WeatherData?, main: MainData?, wind: WindData?, rain: RainData?, snow: SnowData?) {
        self.main = main
        self.weather = [weather]
        self.wind = wind
        self.rain = rain
        self.snow = snow
    }
}

struct WeatherData: Decodable{
    let main: String
    let description: String
}

struct MainData: Decodable{
    let temp: Double
    let humidity: Double
}

struct WindData: Decodable{
    let speed: Double
}

struct RainData: Decodable{
    let oneHour: Double
    
    enum CodingKeys: String, CodingKey{
        case oneHour = "1h"
    }
}

struct SnowData: Decodable{
    let oneHour: Double
    
    enum CodingKeys: String, CodingKey{
        case oneHour = "1h"
    }
}
