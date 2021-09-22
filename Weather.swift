//
//  Weather.swift
//  
//
//  Created by Дарья Воробей on 9/22/21.
//

import Foundation

// MARK: - Weather
struct Weather: Codable {
    let location: Location
    let current: Current
    let forecast: Forecast
}

// MARK: - Current
struct Current: Codable {
    let lastUpdated: String
    let tempC: Int
    let isDay: Int
    let condition: Condition
    let windKph: Int

    enum CodingKeys: String, CodingKey {
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case isDay = "is_day"
        case condition
        case windKph = "wind_kph"
    }
}

// MARK: - Condition
struct Condition: Codable {
    let text: Text
}

enum Text: String, Codable {
    case clear = "Clear"
    case cloudy = "Cloudy"
    case partlyCloudy = "Partly cloudy"
}

// MARK: - Forecast
struct Forecast: Codable {
    let forecastday: [Forecastday]
}

// MARK: - Forecastday
struct Forecastday: Codable {
    let date: String
    let day: Day
    let hour: [Hour]

    enum CodingKeys: String, CodingKey {
        case date
        case day, hour
    }
}

// MARK: - Day
struct Day: Codable {
    let maxtempC, mintempC: Double
    let maxwindKph: Double
    let condition: Condition

    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
        case maxwindKph = "maxwind_kph"
        case condition
    }
}

// MARK: - Hour
struct Hour: Codable {
    let time: String
    let tempC: Double
    let isDay: Int
    let condition: Condition
    let windKph: Double

    enum CodingKeys: String, CodingKey {
        case time
        case tempC = "temp_c"
        case isDay = "is_day"
        case condition
        case windKph = "wind_kph"
    }
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let lat, lon: Double
    let localtime: String

    enum CodingKeys: String, CodingKey {
        case name, lat, lon
        case localtime
    }
}
