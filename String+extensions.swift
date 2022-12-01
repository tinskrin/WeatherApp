//
//  String+extensions.swift
//  WeatherApp
//
//  Created by Kris on 25.11.2022.
//

import Foundation

extension String {

	func localized() -> String {
		return NSLocalizedString(self, comment: "")
	}
}
