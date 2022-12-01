//
//  WeatherHeaderTableViewCell.swift
//  WeatherApp
//
//  Created by Kris on 26.11.2022.
//

import UIKit

class WeatherHeaderTableViewCell: UITableViewCell {

	private let cityLabel: UILabel = {
		let cityLabel = UILabel()
		cityLabel.translatesAutoresizingMaskIntoConstraints = false
		cityLabel.textColor = .white
//		cityLabel.text = "Choose your city"
		cityLabel.font = UIFont(name: "PingFangHK-Regular", size: 40)
		cityLabel.textAlignment = .center
		return cityLabel
	}()

	private let conditionLabel: UILabel = {
		let conditionLabel = UILabel()
		conditionLabel.translatesAutoresizingMaskIntoConstraints = false
		conditionLabel.textColor = .white
		conditionLabel.font = UIFont(name: "PingFangHK-Light", size: 20)
		conditionLabel.textAlignment = .center
		return conditionLabel
	}()

	private let temperatureLabel: UILabel = {
		let temperatureLabel = UILabel()
		temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
		temperatureLabel.font = UIFont(name: "PingFangHK-Regular", size: 40)
//		temperatureLabel.textColor = UIColor(red: 0.83, green: 0.77, blue: 0.98, alpha: 0.6)
		temperatureLabel.textColor = .white
		temperatureLabel.textAlignment = .center
		return temperatureLabel
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupView()
		setupConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupView(){
		addSubview(temperatureLabel)
		addSubview(conditionLabel)
		addSubview(cityLabel)
	}

	func configure(model: WeatherModel?){
		guard let model = model else { return }
		cityLabel.text = model.location.name
		temperatureLabel.text = "\(Int(model.current.temp)) °C"
		conditionLabel.text = model.current.condition.text
	}

	private func setupConstraints(){
		NSLayoutConstraint.activate(
			[
				cityLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
				cityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
				cityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

				conditionLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10),
				conditionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
				conditionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),


				temperatureLabel.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor, constant: 20),
				temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
				temperatureLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
				temperatureLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
			]
		)
	}

}
