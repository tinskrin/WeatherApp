//
//  WeatherDayTableViewCell.swift
//  WeatherApp
//
//  Created by Kris on 27.11.2022.
//

import UIKit

class WeatherDayTableViewCell: UITableViewCell {

	private let dayLabel: UILabel = {
		let dayLabel = UILabel()
		dayLabel.translatesAutoresizingMaskIntoConstraints = false
		dayLabel.textColor = .white
		dayLabel.font = UIFont(name: "PingFangHK-Light", size: 20)
		return dayLabel
	}()

	private let conditionIamge: UIImageView = {
		let conditionImage = UIImageView()
		conditionImage.contentMode = .scaleToFill
		conditionImage.translatesAutoresizingMaskIntoConstraints = false
		return conditionImage
	}()

	private let maxLabel: UILabel = {
		let maxLabel = UILabel()
		maxLabel.translatesAutoresizingMaskIntoConstraints = false
		maxLabel.textColor = .white
		maxLabel.font = UIFont(name: "PingFangHK-Light", size: 20)
		return maxLabel
	}()

	private let minLabel: UILabel = {
		let maxLabel = UILabel()
		maxLabel.translatesAutoresizingMaskIntoConstraints = false
		maxLabel.textColor = .white
		maxLabel.font = UIFont(name: "PingFangHK-Light", size: 20)
		return maxLabel
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupView()
		setupConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(with model: WeatherModel.Forecast.ForecastDay?) {
		guard let model = model else { return }
		if var imageName = model.day.condition.icon.split(separator: "/").last.map({ String($0) }) {
			if model.day.condition.icon.contains("day") {
				imageName = "day" + imageName
			}
			conditionIamge.image = UIImage(named: imageName)
		}
		dayLabel.text = getDayNameBy(stringDate: model.date)
		maxLabel.text = "\(Int(model.day.maxtempC))"
		minLabel.text = "\(Int(model.day.mintempC))"
	}
	private func getDayNameBy(stringDate: String) -> String {
		let dateFormatter  = DateFormatter()
		dateFormatter.dateFormat = "YYYY-MM-dd"
		let date = dateFormatter.date(from: stringDate)!
		dateFormatter.dateFormat = "EEEE"
		return dateFormatter.string(from: date)
	}

	private func setupView(){
		addSubview(dayLabel)
		addSubview(conditionIamge)
		addSubview(maxLabel)
		addSubview(minLabel)
	}

	private func setupConstraints(){

		NSLayoutConstraint.activate(
			[
				dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
				dayLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
				dayLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),

				conditionIamge.centerXAnchor.constraint(equalTo: centerXAnchor),
				conditionIamge.heightAnchor.constraint(equalToConstant: 24),
				conditionIamge.widthAnchor.constraint(equalToConstant: 24),
				conditionIamge.topAnchor.constraint(equalTo: topAnchor, constant: 5),

				maxLabel.leadingAnchor.constraint(equalTo: conditionIamge.trailingAnchor, constant: 80),
				maxLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
				maxLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),

				minLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
				minLabel.leadingAnchor.constraint(equalTo: maxLabel.trailingAnchor, constant: -10),
				minLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
				minLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),


				]
			)
	}
}
