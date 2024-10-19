import Foundation

struct HourlyForecastModel: Decodable{
    let forecast: Forecast
}

struct Forecast: Decodable{
    let forecastday: [ForecastDay]
}

struct ForecastDay: Decodable{
    let hour: [Hour]
}

struct Hour: Decodable{
    let tempC: Decimal
    let condition: Condition
}

struct Condition: Decodable{
    let code: Int
}
