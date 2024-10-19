import UIKit

class HourForecastCollectionViewCell: UICollectionViewCell {
    
    var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.text = "00:00"
        timeLabel.tintColor = .fromHex("2C2C2C")
        timeLabel.font = UIFont(name: "Poppins-Medium", size: 12)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeLabel
    }()
    var tempLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.text = "19°"
        tempLabel.tintColor = .fromHex("2C2C2C")
        tempLabel.font = UIFont(name: "Poppins-Medium", size: 12)
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        return tempLabel
    }()
    var weatherImage: UIImageView = {
        let weatherImage = UIImageView()
        weatherImage.contentMode = .scaleAspectFill
        weatherImage.image = UIImage(named: "cloudyAndSun")
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        return weatherImage
    }()
    
    var degreeSign: UIImageView = {
        let degreeSign = UIImageView()
        degreeSign.contentMode = .scaleAspectFill
        degreeSign.image = UIImage(named: "degreeSign")
        degreeSign.translatesAutoresizingMaskIntoConstraints = false
        return degreeSign
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .fromHex("FDFCFC")
        contentView.addSubview(weatherImage)
//        contentView.addSubview(degreeSign)
        contentView.addSubview(tempLabel)
        contentView.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            weatherImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherImage.heightAnchor.constraint(equalToConstant: contentView.frame.width / 1.5),
            weatherImage.widthAnchor.constraint(equalTo: weatherImage.heightAnchor),
            tempLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor),
            tempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            tempLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            timeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: weatherImage.topAnchor),
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
//            degreeSign.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: (contentView.frame.height - weatherImage.frame.height) / 15),
//            degreeSign.leadingAnchor.constraint(equalTo: tempLabel.trailingAnchor, constant: 1),
//            degreeSign.heightAnchor.constraint(equalToConstant: contentView.frame.width / 15),
//            degreeSign.widthAnchor.constraint(equalTo: degreeSign.heightAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
