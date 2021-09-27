//
//  Forecast.swift
//  NetApi
//
//  Created by Дарья Воробей on 9/27/21.
//

import Foundation

// MARK: - Welcome
public struct Welcome: Codable {
    public let data: [Datum]
    public let cityName: String

    public enum CodingKeys: String, CodingKey {
        case data
        case cityName = "city_name"
    }
}

// MARK: - Datum
public struct Datum: Codable {
   
    public let highTemp: Double
    public let clouds: Int
    public let windSpd: Double
    public let validDate: String
    public let weather: WeatherCondition
    public let precip, lowTemp, maxTemp: Double
    public let minTemp: Double

    public enum CodingKeys: String, CodingKey {
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
public struct WeatherCondition: Codable {
    public let code: Int

    public enum CodingKeys: String, CodingKey {
        case code
    }
}
