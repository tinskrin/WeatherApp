//
//  ViewController.swift
//  WeatherApp
//
//  Created by Kris on 09.11.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

	private let backgroundImage: UIImageView = {
		let backgroundImage = UIImageView()
		backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
		backgroundImage.alpha = 0.8
		backgroundImage.translatesAutoresizingMaskIntoConstraints = false
		return backgroundImage
	}()
	private let searchButton: UIButton = {
		let searchButton = UIButton()
		let searchImage = UIImage(named: "search")
		searchButton.setBackgroundImage(searchImage, for: .normal)
		searchButton.translatesAutoresizingMaskIntoConstraints = false
		return searchButton
	}()

	private let weatherTableView: UITableView = {
		let weatherTableView = UITableView()
		weatherTableView.translatesAutoresizingMaskIntoConstraints = false
		return weatherTableView
	}()

	private var weatherService = WeatherService()
	private let locationManager = CLLocationManager()
	private var weatherModel: WeatherModel?

	override func viewDidLoad() {
		super.viewDidLoad()
		addViews()
		setupConstraints()
		addRecognizers()
		setupView()
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
		locationManager.requestAlwaysAuthorization()
		locationManager.requestLocation()
		locationManager.startUpdatingLocation()
		weatherTableView.backgroundColor = .clear
	}

	private func addViews(){
		view.addSubview(backgroundImage)
		view.addSubview(weatherTableView)
		view.addSubview(searchButton)
	}

	private func setupView(){
		view.backgroundColor = .black
		weatherTableView.delegate = self
		weatherTableView.dataSource = self
		weatherTableView.register(WeatherHeaderTableViewCell.self, forCellReuseIdentifier: "WeatherHeaderTableViewCell")
		weatherTableView.register(WeatherDayTableViewCell.self, forCellReuseIdentifier: "WeatherDayTableViewCell")
		weatherTableView.register(CurrentDayTableViewCell.self, forCellReuseIdentifier: "WeatherCurrentDayTableViewCell")
	}

	private func createBackground(model: WeatherModel?) {
		guard let model = model else { return }
		if model.current.isDay == 1 {
			backgroundImage.image = UIImage(named: "dayBackground")
		} else {
			backgroundImage.image = UIImage(named: "nightBackground")
		}
	}

	private func addRecognizers(){
		let searchRecognizer = UITapGestureRecognizer(target: self, action: #selector(searchButtonPressed))
		searchButton.addGestureRecognizer(searchRecognizer)
	}

	@objc private func searchButtonPressed(){
		let cityAlert = UIAlertController(title: "Enter city name".localized(), message: "", preferredStyle: .alert)
		let cancelAction = UIAlertAction(title: "Cancel".localized(), style: .cancel)
		let searchAction = UIAlertAction(title: "Search".localized(), style: .default) { [weak self] _ in
			if let city = cityAlert.textFields?.first?.text {
				self?.updateWeather(text: city)
			}
		}
		cityAlert.addAction(cancelAction)
		cityAlert.addAction(searchAction)
		cityAlert.addTextField()
		present(cityAlert, animated: true)
	}

	private func updateWeather(text: String) {
		weatherService.getCurrentWeather(city: text) { model in
			self.createBackground(model: model)
			self.weatherModel = model
			self.weatherTableView.reloadData()
		}
	}

	private func setupConstraints(){
		NSLayoutConstraint.activate(
			[
				weatherTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
				weatherTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
				weatherTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
				weatherTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

				searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
				searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
				searchButton.widthAnchor.constraint(equalToConstant: 40),
				searchButton.heightAnchor.constraint(equalToConstant: 40),

				backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
				backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
				backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
				backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			]
		)
	}
}

extension ViewController: CLLocationManagerDelegate {

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		let location: CLLocationCoordinate2D = manager.location!.coordinate
		updateWeather(text: "\(location.latitude), \(location.longitude)")
		manager.stopUpdatingLocation()
	}

	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print(error)
	}

}

extension ViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.section == 0 {
			guard let headerCell = tableView.dequeueReusableCell(withIdentifier: "WeatherHeaderTableViewCell", for: indexPath) as? WeatherHeaderTableViewCell else { return UITableViewCell() }
		headerCell.backgroundColor = .clear
			headerCell.selectionStyle = .none
			headerCell.configure(model: weatherModel)
			return headerCell
		} else if indexPath.section == 1 {
			guard let dayCell = tableView.dequeueReusableCell(withIdentifier: "WeatherDayTableViewCell", for: indexPath) as? WeatherDayTableViewCell else { return UITableViewCell() }
			dayCell.backgroundColor = .clear
			dayCell.selectionStyle = .none
			dayCell.configure(with: weatherModel?.forecast.forecastday[indexPath.row + 1])
			return dayCell
		} else if indexPath.section == 2 {
			guard let currentDayCell = tableView.dequeueReusableCell(withIdentifier: "WeatherCurrentDayTableViewCell", for: indexPath) as? CurrentDayTableViewCell else { return UITableViewCell() }
			currentDayCell.backgroundColor = .clear
			currentDayCell.selectionStyle = .none
			guard let weatherModel = weatherModel else { return UITableViewCell()}
			if indexPath.row == 0 {
				currentDayCell.configure(with: "Humidity".localized(), value: "\(weatherModel.current.humidity)")
			} else if indexPath.row == 1 {
				currentDayCell.configure(with: "Feels like".localized(), value: "\(Int(weatherModel.current.feelslikeC))")
			} else if indexPath.row == 2 {
				currentDayCell.configure(with: "Pressure".localized(), value: "\(Int(weatherModel.current.pressureMb))")
			} else if indexPath.row == 3 {
				currentDayCell.configure(with: "Wind".localized(), value: "\(Int(weatherModel.current.windKph))")
			} else if indexPath.row == 4 {
				currentDayCell.configure(with: "UV index".localized(), value: "\(Int(weatherModel.current.uv))")
			}
			return currentDayCell
		}
		return UITableViewCell()
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return 1
		}
		if section == 1 {
			guard let model = weatherModel?.forecast.forecastday else { return 0 }
			return model.count - 1
		} else if section == 2 {
			return 5
		}
		else {
			return 2
		}
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		3
	}
}

extension ViewController: UITableViewDelegate {
	public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
	   let view = UIView()
		if section == 1 {
			view.backgroundColor = .gray
		}
	   return view
   }

   public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
	   if section == 1 {
		   return 1
	   } else {
		   return 0
	   }
   }
}
