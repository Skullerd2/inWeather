import Foundation
import Alamofire

final class NetworkManager{
    
    static let shared = NetworkManager()
    private let key: String = "ced4c7d19b814dbf8f7150329240411"
    private init() {}
    
    func fetchCurrentWeather(lat: Double, lon: Double, completion: @escaping (Result<WeatherModel, AFError>) -> Void){
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request("https://api.weatherapi.com/v1/current.json?key=\(key)&q=\(lat),\(lon)&aqi=no")
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
        
        AF.request("https://api.weatherapi.com/v1/current.json?key=\(key)&q=\(city)&aqi=no")
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
        
        AF.request("https://api.weatherapi.com/v1/forecast.json?key=\(key)&q=\(lat),\(lon)&days=3&aqi=no&alerts=no")
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
        
        AF.request("https://api.weatherapi.com/v1/forecast.json?key=\(key)&q=\(city)&days=3&aqi=no&alerts=no")
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

