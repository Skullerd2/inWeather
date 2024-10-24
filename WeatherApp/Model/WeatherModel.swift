import Foundation

struct WeatherModel: Decodable{
    let current: CurrentWeather?
    
    init(current: CurrentWeather? = nil) {
        self.current = current
    }
}

struct CurrentWeather: Decodable{
    let tempC: Double
    let feelslikeC: Double
    let windMph: Double
    let humidity: Int
    let condition: ConditionWeather
    init(tempC: Decimal, feelslikeC: Decimal, windMph: Decimal, humidity: Int, condition: ConditionWeather) {
        self.tempC = (tempC as NSDecimalNumber).doubleValue
        self.feelslikeC = (feelslikeC as NSDecimalNumber).doubleValue
        self.windMph = (feelslikeC as NSDecimalNumber).doubleValue
        self.humidity = humidity
        self.condition = condition
    }
}

struct ConditionWeather: Decodable{
    let code: Int
}
