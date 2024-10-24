import Foundation
import Alamofire


final class NetworkManager{
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchCurrentWeather(lat: Double, lon: Double, completion: @escaping (Result<WeatherModel, AFError>) -> Void){
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request("https://api.weatherapi.com/v1/current.json?key=8be306a52fd848c0972142834241910&q=\(lat),\(lon)&aqi=no")
            .validate()
            .responseDecodable(of: WeatherModel.self, decoder: decoder) { dataResponse in
                switch dataResponse.result{
                case .success(let weather):
                    print("Done!")
                    completion(.success(weather))
                case .failure(let error):
                    print("Error!")
                    completion(.failure(error))
                }
            }
    }
    
    func fetchCurrentWeather(city: String, completion: @escaping (Result<WeatherModel, AFError>) -> Void){
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request("https://api.weatherapi.com/v1/current.json?key=8be306a52fd848c0972142834241910&q=\(city)&aqi=no")
            .validate()
            .responseDecodable(of: WeatherModel.self, decoder: decoder) { dataResponse in
                switch dataResponse.result{
                case .success(let weather):
                    print("Done!")
                    completion(.success(weather))
                case .failure(let error):
                    print("Error!")
                    completion(.failure(error))
                }
            }
    }
    
    func fetchHourlyForecast(lat: Double, lon: Double, completion: @escaping (Result<HourlyForecastModel, AFError>) -> Void){
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request("https://api.weatherapi.com/v1/forecast.json?key=8be306a52fd848c0972142834241910&q=\(lat),\(lon)&days=3&aqi=no&alerts=no")
            .validate()
            .responseDecodable(of: HourlyForecastModel.self, decoder: decoder) { dataResponse in
                switch dataResponse.result{
                case .success(let hourlyForecast):
                    print("Done!")
                    completion(.success(hourlyForecast))
                case .failure(let error):
                    print("Error!")
                    completion(.failure(error))
                }
            }
    }
    
    func fetchHourlyForecast(city: String, completion: @escaping (Result<HourlyForecastModel, AFError>) -> Void){
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request("https://api.weatherapi.com/v1/forecast.json?key=8be306a52fd848c0972142834241910&q=\(city)&days=3&aqi=no&alerts=no")
            .validate()
            .responseDecodable(of: HourlyForecastModel.self, decoder: decoder) { dataResponse in
                switch dataResponse.result{
                case .success(let hourlyForecast):
                    print("Done!")
                    completion(.success(hourlyForecast))
                case .failure(let error):
                    print("Error!")
                    completion(.failure(error))
                }
            }
    }
}

