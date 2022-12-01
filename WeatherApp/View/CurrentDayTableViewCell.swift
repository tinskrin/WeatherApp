//
//  CurrentDayTableViewCell.swift
//  WeatherApp
//
//  Created by Kris on 27.11.2022.
//

import UIKit

class CurrentDayTableViewCell: UITableViewCell {

	private let conditionLabel: UILabel = {
		let conditionLabel = UILabel()
		conditionLabel.translatesAutoresizingMaskIntoConstraints = false
		conditionLabel.textColor = .white
		conditionLabel.font = UIFont(name: "PingFangHK-Light", size: 20)
		return conditionLabel
	}()

	private let conditionValue: UILabel = {
		let conditionValue = UILabel()
		conditionValue.translatesAutoresizingMaskIntoConstraints = false
		conditionValue.textColor = .white
		conditionValue.font = UIFont(name: "PingFangHK-Light", size: 20)
		return conditionValue
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
		addSubview(conditionLabel)
		addSubview(conditionValue)
	}

	func configure(with label: String, value: String) {
		conditionValue.text = value
		conditionLabel.text = label
	}

	private func setupConstraints(){
		NSLayoutConstraint.activate(
			[
				conditionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
				conditionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
				conditionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),

				conditionValue.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
				conditionValue.topAnchor.constraint(equalTo: topAnchor, constant: 5),
				conditionValue.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
				
				]
			)
	}
	
}
