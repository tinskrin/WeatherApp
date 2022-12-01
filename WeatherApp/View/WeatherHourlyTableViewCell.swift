//
//  WeatherHourlyTableViewCell.swift
//  WeatherApp
//
//  Created by Kris on 26.11.2022.
//

import UIKit

class WeatherHourlyTableViewCell: UITableViewCell {

	private var hourlyCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.minimumLineSpacing = 0
		layout.scrollDirection = .horizontal
		let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
		view.isPagingEnabled = true
		view.backgroundColor = .clear
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
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
		addSubview(hourlyCollectionView)
	}

	private func setupConstraints(){
		NSLayoutConstraint.activate(
			[
				hourlyCollectionView.topAnchor.constraint(equalTo: topAnchor),
				hourlyCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
				hourlyCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
				hourlyCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor)
			]
		)
	}

}

