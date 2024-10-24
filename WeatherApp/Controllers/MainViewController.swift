import UIKit
import CoreLocation
import SwiftUI
struct ViewControllerPrewiew: UIViewControllerRepresentable{
    
    let viewControllerGenerator: () -> UIViewController
    
    init(viewControllerGenerator: @escaping () -> UIViewController) {
        self.viewControllerGenerator = viewControllerGenerator
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        viewControllerGenerator()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
}

class MainViewController: UIViewController, UITextFieldDelegate {
    
    private let networkManager = NetworkManager.shared
    private let locationManager = LocationManager.shared
    
    private var location = LocationModel(main: nil)
    private var weather = WeatherModel(current: nil)
    
    private var currentCity: String = ""
    
    var weatherInLocation = CityWeatherModel(cityName: "-", temp: 0, feelsLike: 0, weather: 1000, humiditiy: 0, windSpeed: 0)
    var cityList: [String] = []
    
    var data = ["Ячейка 1", "Ячейка 2", "Ячейка 3"]
    
    var time: [String] = ["now"]
    
    var weatherData: [(key: String, value: String)] = [("Feels like", "19"), ("Wind", "19km/h"), ("Humidity", "64%")]
    var forecastOneHourTemp: [Int] = []
    var forecastOneHourWeather: [Int] = []
    var currentHour: Int = 0
    
    //Elements of interface
    let pageControl = UIPageControl()
    var weatherImageView = UIImageView()
    let searchTextField = UITextField()
    let cityNameLabel = UILabel()
    let degreeLabel = UILabel()
    let degreeSign = UIImageView()
    let locationImageView = UIImageView()
    var tableView = UITableView()
    let todayWeatherLabel = UILabel()
    let forecastButton = UIButton()
    
    let layout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        fetchCurrentTime()
        fetchCurrentWeatherInCurrentLocation()
        
        searchTextField.delegate = self
        addSearchTextField()
        addWeatherImageView()
        addCityNameLabel()
        addLocationImage()
        addDegreeLabel()
        addDegreeSign()
        addTableView()
        addTodayWeatherLabel()
        addForecastButton()
        //        addCollectionView()
    }
    
    
    func fetchCurrentTime(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:00"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let calendar = Calendar.current
        
        var currentDate = Date()
        
        for i in 0..<23{
            currentDate = calendar.date(byAdding: .hour, value: 1, to: currentDate)!
            let hourString = dateFormatter.string(from: currentDate)
            if i == 0{
                print(hourString)
                currentHour = Int(hourString.prefix(2))!
            }
            time.append("\(hourString)")
        }
    }
}

struct ViewControllerProvider: PreviewProvider{
    static var previews: some View{
        ViewControllerPrewiew{
            MainViewController()
        }.edgesIgnoringSafeArea(.all)
    }
}

//MARK: - Adding elements
extension MainViewController{
    
    func addCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(HourForecastCollectionViewCell.self, forCellWithReuseIdentifier: "hourCell")
        collectionView.backgroundColor = .clear
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -2),
            collectionView.topAnchor.constraint(equalTo: todayWeatherLabel.bottomAnchor, constant: 13)
        ])
    }
    
    func addForecastButton(){
        forecastButton.setTitle("Next 7 days", for: .normal)
        forecastButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        forecastButton.semanticContentAttribute = .forceRightToLeft
        forecastButton.tintColor = .gray
        forecastButton.setTitleColor(.gray, for: .normal)
        forecastButton.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 15)
        forecastButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(forecastButton)
        
        NSLayoutConstraint.activate([
            forecastButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            forecastButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 5),
        ])
    }
    
    func addTodayWeatherLabel(){
        todayWeatherLabel.text = "Today"
        todayWeatherLabel.font = UIFont(name: "Poppins-Medium", size: 15)
        todayWeatherLabel.translatesAutoresizingMaskIntoConstraints = false
        todayWeatherLabel.textColor = .fromHex("2C2C2C")
        
        view.addSubview(todayWeatherLabel)
        
        NSLayoutConstraint.activate([
            todayWeatherLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            todayWeatherLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 5)
        ])
    }
    
    func addTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.isUserInteractionEnabled = false
        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        let height = view.frame.height / 11
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: degreeLabel.bottomAnchor, constant: 3),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: height * CGFloat(data.count) + 2 * height / 10)
        ])
    }
    
    func addLocationImage(){
        locationImageView.image = UIImage(named: "locationIcon")
        locationImageView.tintColor = .fromHex("2C2C2C")
        locationImageView.contentMode = .scaleToFill
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(locationImageView)
        NSLayoutConstraint.activate([
            locationImageView.leadingAnchor.constraint(equalTo: cityNameLabel.trailingAnchor, constant: 5),
            locationImageView.heightAnchor.constraint(equalToConstant: 23),
            locationImageView.widthAnchor.constraint(equalTo: locationImageView.heightAnchor),
            locationImageView.centerYAnchor.constraint(equalTo: cityNameLabel.centerYAnchor)
        ])
    }
    
    func addDegreeSign(){
        degreeSign.image = UIImage(named: "degreeSign")
        degreeSign.tintColor = .fromHex("2C2C2C")
        degreeSign.contentMode = .scaleToFill
        view.addSubview(degreeSign)
        degreeSign.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            degreeSign.heightAnchor.constraint(equalToConstant: 8),
            degreeSign.widthAnchor.constraint(equalToConstant: 8),
            degreeSign.leadingAnchor.constraint(equalTo: degreeLabel.trailingAnchor, constant: 0),
            degreeSign.topAnchor.constraint(equalTo: degreeLabel.topAnchor, constant: 18)
        ])
    }
    
    func addDegreeLabel(){
        degreeLabel.text = String(Int(weatherInLocation.temp))
        degreeLabel.font = UIFont(name: "Poppins-Medium", size: 70)
        degreeLabel.tintColor = .fromHex("2C2C2C")
        degreeLabel.translatesAutoresizingMaskIntoConstraints = false
        degreeLabel.textAlignment = .center
        view.addSubview(degreeLabel)
        NSLayoutConstraint.activate([
            degreeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            degreeLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: -10),
        ])
    }
    
    func addCityNameLabel(){
        cityNameLabel.text = weatherInLocation.cityName
        cityNameLabel.font = UIFont(name: "Poppins-SemiBold", size: 30)
        cityNameLabel.tintColor = .fromHex("2C2C2C")
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        cityNameLabel.textAlignment = .center
        view.addSubview(cityNameLabel)
        NSLayoutConstraint.activate([
            cityNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityNameLabel.centerYAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: 50)
        ])
    }
    
    func addWeatherImageView(){
        weatherImageView.image = UIImage(named: "cloudyAndSun")
        
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.contentMode = .scaleAspectFill
        view.addSubview(weatherImageView)
        NSLayoutConstraint.activate([
            weatherImageView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 40),
            weatherImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherImageView.widthAnchor.constraint(equalToConstant: view.frame.height / 7),
            weatherImageView.heightAnchor.constraint(equalTo: weatherImageView.widthAnchor),
        ])
    }
    
    func addSearchTextField(){
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.backgroundColor = UIColor(red: 0.992, green: 0.988, blue: 0.988, alpha: 1)
        searchTextField.setPlaceholder("Search Location", icon: UIImage(systemName: "magnifyingglass"))
        searchTextField.layer.cornerRadius = 15
        searchTextField.font = UIFont(name: "Poppins-Regular", size: 15)
        view.addSubview(searchTextField)
        
        NSLayoutConstraint.activate([
            searchTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            searchTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            searchTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.fromHex("C4C4C4"),
            NSAttributedString.Key.paragraphStyle: {
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.headIndent = 16
                return paragraphStyle
            }()
        ]
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Search Location", attributes: attributes)
    }
    
    //    func addPageControl(){
    //        pageControl.currentPage = 1
    //        pageControl.numberOfPages = 3
    //        pageControl.pageIndicatorTintColor = .fromHex("001F70")
    //        pageControl.backgroundColor = .fromHex("C4C4C4")
    //        view.addSubview(pageControl)
    //
    //        NSLayoutConstraint.activate([
    //            pageControl.topAnchor.constraint(equalTo: searchTextField.topAnchor, constant: 5)
    //            pageControl.centerXAnchor.
    //        ])
    //    }
}


//MARK: - Extension to set searchField

extension MainViewController{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        searchCity()
        searchTextField.text = ""
        return true
    }
    
    func searchCity(){
        if searchTextField.text == ""{
            return
        }
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(searchTextField.text!){ [weak self] (city, error) in
            guard let city = city?.first else{
                self?.presentAlertError(error: "Unknown city!")
                return
            }
            if let cityName = city.locality{
                self?.cityList.append(cityName)
            }
            
        }
    }
}

//MARK: - Extension to add CollectionView

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hourCell", for: indexPath) as? HourForecastCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.layer.cornerRadius = 11
        cell.timeLabel.text = time[indexPath.item]
        if indexPath.row == 0{
            cell.weatherImage.image = self.weatherImageView.image
            cell.tempLabel.text = "\(degreeLabel.text!)°"
        } else{
            if forecastOneHourWeather.count >= 23{
                updateImageForecast(imageView: &cell.weatherImage, code: forecastOneHourWeather[indexPath.item])
                cell.tempLabel.text = "\(forecastOneHourTemp[indexPath.item])°"
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 6.7, height: collectionView.frame.height)
    }
}

//MARK: - Extension to add tableView

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        weatherData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? WeatherTableViewCell else { return  UITableViewCell() }
        
        cell.layer.cornerRadius = 11
        cell.titleLabel.text = weatherData[indexPath.section].key
        cell.dataLabel.text = weatherData[indexPath.section].value
        cell.titleLabel.textColor = .fromHex("2c2c2c")
        cell.dataLabel.textColor = .fromHex("2c2c2c")
        cell.backgroundColor = .fromHex("FDFCFC")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 12
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return (view.frame.height / 12) / 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

//MARK: - Network

extension MainViewController{
    
    private func fetchHourlyForecast(lat: Double, lon: Double){
        networkManager.fetchHourlyForecast(lat: lat, lon: lon) { [weak self] result in
            switch result {
            case .success(let forecast):
                self?.createArray(dayArray: forecast.forecast.forecastday)
            case .failure(let failure):
                self?.presentAlertError(error: "Error in fetching hour forecast")
                print(failure)
            }
            self?.addCollectionView()
        }
    }
    
    private func fetchCurrentWeather(lat: Double, lon: Double, city: String){
        networkManager.fetchCurrentWeather(lat: lat, lon: lon) { [weak self] result in
            switch result{
            case .success(let weather):
                self?.weather = weather
                //                    let newCity = CityWeatherModel(cityName: city, temp: weather.main!.temp, weather: weather.weather[0]!.description, humiditiy: weather.main!.humidity, windSpeed: weather.wind!.speed, rain: weather.rain?.oneHour, snow: weather.snow?.oneHour)
                //                    self?.cityList.append(newCity)
                let weather = CityWeatherModel(cityName: city, temp: weather.current!.tempC, feelsLike: weather.current!.feelslikeC, weather: weather.current!.condition.code, humiditiy: weather.current!.humidity, windSpeed: weather.current!.windMph)
                print(weather)
                self?.weatherInLocation = weather
                self?.tableView.reloadData()
                self?.updateImageForecast(imageView: &self!.weatherImageView, code: weather.weatherCode)
                self?.degreeLabel.text = String(Int((weather.temp).rounded()))
                self?.weatherData[0].value = "\(String(Int((weather.feelsLike).rounded())))°"
                self?.weatherData[1].value = "\(String(Int((weather.windSpeed).rounded())))m/h"
                self?.weatherData[2].value = "\(String(weather.humiditiy))%"
            case .failure(let error):
                self?.presentAlertError(error: "Error in fetching current weather")
                print(error)
            }
            
        }
    }
    
    private func fetchCurrentWeatherInCurrentLocation(){
        var city: String = ""
        
        self.locationManager.fetchCurrentLocation() { [weak self] lat, lon in
            self?.fetchHourlyForecast(lat: lat, lon: lon)
            self?.locationManager.getCity(lat: lat, lon: lon) { location in
                city = location
                self?.cityNameLabel.text = city
                self?.fetchCurrentWeather(lat: lat, lon: lon, city: city)
                print(city)
            }
        }
    }
}

extension MainViewController{
    private func presentAlertError(error: String){
        let alertController = UIAlertController(title: "Error!", message: error, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Okey", style: .cancel)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    
}

extension MainViewController{
    private func createArray(dayArray: [ForecastDay]){
        print(dayArray)
        for i in currentHour...23{
            forecastOneHourTemp.append(Int(truncating: NSDecimalNumber(decimal: dayArray[0].hour[i].tempC)))
            forecastOneHourWeather.append(dayArray[0].hour[i].condition.code)
        }
        for i in 0...23{
            if (forecastOneHourTemp.count < 24){
                forecastOneHourTemp.append(Int(truncating: NSDecimalNumber(decimal: dayArray[1].hour[i].tempC)))
                forecastOneHourWeather.append(dayArray[1].hour[i].condition.code)
            } else{
                break
            }
        }
        print(forecastOneHourTemp, forecastOneHourWeather)
    }
    
    private func updateImage(imageView: inout UIImageView, main: String, description: String){
        if main == "Clear"{
            imageView.image = UIImage(named: "sunny")
        } else if main == "Rain" || main == "Snow" || main == "Drizzle" || main == "Thunderstorm"{
            imageView.image = UIImage(named: "rainy")
        } else if main == "Clouds" && description == "few clouds"{
            imageView.image = UIImage(named: "cloudyAndSun")
        } else if main == "Clouds"{
            imageView.image = UIImage(named: "cloudy")
        }
    }
    
    private func updateImageForecast(imageView: inout UIImageView, code: Int){
        if code == 1000{
            imageView.image = UIImage(named: "sunny")
        } else if code == 1003 || code == 3{
            imageView.image = UIImage(named: "cloudyAndSun")
        } else if code >= 1006 && code <= 1147{
            imageView.image = UIImage(named: "cloudy")
        } else {
            imageView.image = UIImage(named: "rainy")
        }
    }
}

extension UITextField{
    func setPlaceholder(_ placeholderText: String, icon: UIImage? = nil, padding: CGFloat = 16){
        let paddingViewLeft = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        let paddingViewRight = UIView(frame: CGRect(x: -padding, y: 0, width: padding, height: self.frame.height))
        self.rightView = paddingViewRight
        self.rightViewMode = .always
        self.leftView = paddingViewLeft
        self.leftViewMode = .always
        
        if let icon = icon {
            let iconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            iconView.image = icon
            iconView.contentMode = .scaleAspectFit
            iconView.tintColor = .fromHex("C4C4C4")
            paddingViewRight.addSubview(iconView)
            iconView.center = paddingViewRight.center
        }
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.fromHex("C4C4C4"),
            .paragraphStyle: {
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.headIndent = padding
                return paragraphStyle
            }()
        ]
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
    }
}

//MARK: - Extension to convert color from hex
extension UIColor {
    static func fromHex(_ hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if (cString.count) != 6 {
            return UIColor.gray
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
