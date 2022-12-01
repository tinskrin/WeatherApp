//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Kris on 09.11.2022.
//

import Foundation

struct WeatherModel: Decodable {
	let location: Location
	let current: Current
	let forecast: Forecast

	struct Location: Decodable {
		let name: String
	}

	struct Current: Decodable {
		let temp: Double
		let isDay: Int
		let condition: Condition
		let windKph: Double
		let pressureMb: Double
		let humidity: Int
		let feelslikeC: Double
		let uv: Double


		enum CodingKeys: String, CodingKey {
			case temp = "temp_c"
			case isDay = "is_day"
			case condition = "condition"
			case windKph = "wind_kph"
			case pressureMb = "pressure_mb"
			case humidity = "humidity"
			case feelslikeC = "feelslike_c"
			case uv = "uv"
		}
	}
}

extension WeatherModel {

	struct Condition: Decodable {
		let text: String
		let icon: String
	}

	struct Forecast: Decodable {
		let forecastday: [ForecastDay]

		struct ForecastDay: Decodable {
			let date: String
			let day: DayCondition


			struct DayCondition: Decodable {
				let maxtempC: Double
				let mintempC: Double
				let condition: Condition

				enum CodingKeys: String, CodingKey {
					case maxtempC = "maxtemp_c"
					case mintempC = "mintemp_c"
					case condition = "condition"
				}
			}
		}
	}
}
