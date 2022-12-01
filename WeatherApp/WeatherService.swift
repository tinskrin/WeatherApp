//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Kris on 09.11.2022.
//

import Foundation

class WeatherService {

	private let apiKey = "Your Api key here"
	private let language = "en"

	func getCurrentWeather(city: String, callback: @escaping (WeatherModel?) -> Void) {
		guard let city = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
			  let url = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(city)&days=8&aqi=no&alerts=no&lang=\(language.localized())") else { return }
		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			do {
				let model = try JSONDecoder().decode(WeatherModel.self, from: data!)
				print(model)
				DispatchQueue.main.async {
					callback(model)
				}
			} catch {
				print(error)
			}
		}
		task.resume()

	}
}
