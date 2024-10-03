import Foundation
import Alamofire


final class NetworkManager{
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchCurrentWeather(lat: Double, lon: Double, completion: @escaping (Result<WeatherModel, AFError>) -> Void){
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request("https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=8d46173d317133df98d24654a48cd96f&units=metric")
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
}

