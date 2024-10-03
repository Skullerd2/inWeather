import UIKit
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

class MainViewController: UIViewController {
    
    var data = ["Ячейка 1", "Ячейка 2", "Ячейка 3"]
    
    var time: [String] = ["now"]
    
    var weatherData: [(key: String, value: String)] = [("Feels like", "19"), ("Wind", "19km/h"), ("Humidity", "64%")]
    
    //Elements of interface
    let pageControl = UIPageControl()
    let weatherImageView = UIImageView()
    let searchTextField = UITextField()
    let cityNameLabel = UILabel()
    let degreeLabel = UILabel()
    let degreeSign = UIImageView()
    let locationImageView = UIImageView()
    var tableView = UITableView()
    let todayWeatherLabel = UILabel()
    let forecastButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCurrentTime()
        addSearchTextField()
        addWeatherImageView()
        addCityNameLabel()
        addLocationImage()
        addDegreeLabel()
        addDegreeSign()
        addTableView()
        addTodayWeatherLabel()
        addForecastButton()
        addCollectionView()
    }
    
    
    func fetchCurrentTime(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        
        let currentHourString = dateFormatter.string(from: Date())
        var hourInt = Int(currentHourString)!
        for i in 0...22{
            hourInt += 1
            if hourInt == 24{
                hourInt = 0
                time.append("00")
                continue
            } else if hourInt < 10{
                time.append("0\(hourInt)")
            } else{
                time.append(String(hourInt))
            }
                
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
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: todayWeatherLabel.bottomAnchor, constant: 13)
        ])
    }
    
    func addForecastButton(){
        forecastButton.setTitle("Next 7 days", for: .normal)
        forecastButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        forecastButton.semanticContentAttribute = .forceRightToLeft
        forecastButton.tintColor = .fromHex("2C2C2C")
        forecastButton.setTitleColor(.fromHex("2C2C2C"), for: .normal)
        forecastButton.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 15)
        forecastButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(forecastButton)
        
        NSLayoutConstraint.activate([
            forecastButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            forecastButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
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
            todayWeatherLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20)
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
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: degreeLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: 70 * CGFloat(data.count) + 9 * 2)
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
        degreeLabel.text = "19"
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
        cityNameLabel.text = "St. Petersburg"
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
            weatherImageView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 50),
            weatherImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherImageView.widthAnchor.constraint(equalToConstant: 123),
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


//MARK: - Extension to add CollectionView

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hourCell", for: indexPath) as? HourForecastCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.layer.cornerRadius = 13
        cell.timeLabel.text = time[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: collectionView.frame.height)
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
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 9
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
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
