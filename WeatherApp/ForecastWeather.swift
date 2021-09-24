//
//  ForecastWeather.swift
//  WeatherApp
//
//  Created by Darya on 9/24/21.
//

import Foundation

// MARK: - Welcome
public struct Welcome: Codable {
    let data: [Datum]
    let cityName: String

    enum CodingKeys: String, CodingKey {
        case data
        case cityName = "city_name"
    }
}

// MARK: - Datum
struct Datum: Codable {
   
    let highTemp: Double
    let clouds: Int
    let windSpd: Double
    let validDate: String
    let weather: WeatherCondition
    let precip, lowTemp, maxTemp: Double
    let minTemp: Double

    enum CodingKeys: String, CodingKey {
        case highTemp = "high_temp"
        case clouds
        case windSpd = "wind_spd"
        case validDate = "valid_date"
        case weather
        case precip
        case lowTemp = "low_temp"
        case maxTemp = "max_temp"
        case minTemp = "min_temp"
    }
}

// MARK: - Weather
struct WeatherCondition: Codable {
    let code: Int

    enum CodingKeys: String, CodingKey {
        case code
    }
}
