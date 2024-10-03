//
//  CityTableViewCell.swift
//  WeatherApp
//
//  Created by Vadim on 28.08.2024.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.tintColor = .fromHex("9A9A9A")
        label.font = UIFont(name: "Poppins-Medium", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var dataLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.tintColor = .fromHex("9A9A9A")
        label.font = UIFont(name: "Poppins-Medium", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(dataLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dataLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dataLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
