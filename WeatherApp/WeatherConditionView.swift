//
//  WeatherConditionView.swift
//  WeatherApp
//
//  Created by Kris on 14.11.2022.
//

import Foundation
import UIKit

class WeatherConditionView: UIView {

	let conditionNameLabel: UILabel = {
		let conditionNameLabel = UILabel()
		conditionNameLabel.translatesAutoresizingMaskIntoConstraints = false
		conditionNameLabel.font = UIFont(name: "ChalkboardSE-Bold", size: 30)
		conditionNameLabel.textColor = .white
		conditionNameLabel.textAlignment = .center
		return conditionNameLabel
	}()

	let conditionValueLabel: UILabel = {
		let conditionValueLabel = UILabel()
		conditionValueLabel.translatesAutoresizingMaskIntoConstraints = false
		conditionValueLabel.font = UIFont(name: "ChalkboardSE-Light", size: 20)
		conditionValueLabel.textColor = .white
		conditionValueLabel.textAlignment = .center
		return conditionValueLabel
	}()

	let conditionIamge: UIImageView = {
		let conditionImage = UIImageView()
		conditionImage.contentMode = .scaleToFill
		conditionImage.translatesAutoresizingMaskIntoConstraints = false
		return conditionImage
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
		setupConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupView(){
		addSubview(conditionNameLabel)
		addSubview(conditionValueLabel)
		addSubview(conditionIamge)
	}

	func configure(conditionName: String, conditionValue: String, conditionImageName: String){
		conditionNameLabel.text = conditionName
		conditionValueLabel.text = "\(conditionValue)"
		conditionIamge.image = UIImage(named: conditionImageName)
	}

	private func setupConstraints(){
		NSLayoutConstraint.activate(
			[
				conditionNameLabel.topAnchor.constraint(equalTo: topAnchor),

				conditionValueLabel.topAnchor.constraint(equalTo: conditionNameLabel.topAnchor),
				conditionValueLabel.bottomAnchor.constraint(equalTo: conditionNameLabel.bottomAnchor),
				conditionValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
				conditionValueLabel.leadingAnchor.constraint(equalTo: conditionNameLabel.trailingAnchor, constant: 10),

				conditionIamge.topAnchor.constraint(equalTo: topAnchor),
				conditionIamge.bottomAnchor.constraint(equalTo: bottomAnchor),
				conditionIamge.leadingAnchor.constraint(equalTo: leadingAnchor),
				conditionIamge.trailingAnchor.constraint(equalTo: conditionNameLabel.leadingAnchor, constant: -10),
			]
		)
	}
}
