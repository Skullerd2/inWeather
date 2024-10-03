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
        tempLabel.text = "19"
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .fromHex("FDFCFC")
        
        contentView.addSubview(weatherImage)
        contentView.addSubview(tempLabel)
        contentView.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            weatherImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherImage.heightAnchor.constraint(equalToConstant: 40),
            weatherImage.widthAnchor.constraint(equalTo: weatherImage.heightAnchor),
            tempLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 4),
            tempLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            timeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: weatherImage.topAnchor, constant: -4),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
