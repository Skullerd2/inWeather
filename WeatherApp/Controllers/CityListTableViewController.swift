import UIKit

class CityListTableViewController: UITableViewController {
    
    private let networkManager = NetworkManager.shared
    private let locationManager = LocationManager.shared
    
    private var location = LocationModel(main: nil)
    private var weather = WeatherModel(weather: nil, main: nil, wind: nil, rain: nil, snow: nil)
    
    var cityList = [CityWeatherModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCurrentLocation()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}

//MARK: - Network

extension CityListTableViewController{
    
    private func fetchCurrentLocation(){
        locationManager.fetchCurrentLocation() { [weak self] lat, lon in
            var city: String = ""
            self?.locationManager.getCity(lat: lat, lon: lon) { location in
                city = location
            }
            self?.networkManager.fetchCurrentWeather(lat: lat, lon: lon) { [weak self] result in
                switch result{
                case .success(let weather):
                    self?.weather = weather
                    let newCity = CityWeatherModel(cityName: city, temp: weather.main!.temp, weather: weather.weather[0]!.description, humiditiy: weather.main!.humidity, windSpeed: weather.wind!.speed, rain: weather.rain?.oneHour, snow: weather.snow?.oneHour)
                    self?.cityList.append(newCity)
                    print(newCity)
                case .failure(let error):
                    print(error)
                }
                self?.tableView.reloadData()
            }
        }
    }
    
}
