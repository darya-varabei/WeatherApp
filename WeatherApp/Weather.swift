//
//  Weather.swift
//  
//
//  Created by Дарья Воробей on 9/22/21.
//

import Foundation

// MARK: - Weather
public struct Weather: Codable {
    var location: Location
    var current: Current
    var forecast: Forecast
}

// MARK: - Current
public struct Current: Codable {
    var lastUpdated: String
    var tempC: Double
    var isDay: Int
    var condition: Condition
    var windKph: Double

    enum CodingKeys: String, CodingKey {
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case isDay = "is_day"
        case condition
        case windKph = "wind_kph"
    }
}

// MARK: - Condition
public struct Condition: Codable {
    var text: String
}

// MARK: - Forecast
public struct Forecast: Codable {
    var forecastday: [Forecastday]
}

// MARK: - Forecastday
public struct Forecastday: Codable {
    var date: String
    var day: Day
    var hour: [Hour]

    enum CodingKeys: String, CodingKey {
        case date
        case day, hour
    }
}

// MARK: - Day
public struct Day: Codable {
    var maxtempC, mintempC: Double
    var maxwindKph: Double
    var condition: Condition

    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
        case maxwindKph = "maxwind_kph"
        case condition
    }
}

// MARK: - Hour
public struct Hour: Codable {
    var time: String
    var tempC: Double
    var isDay: Int
    var condition: Condition
    var windKph: Double

    enum CodingKeys: String, CodingKey {
        case time
        case tempC = "temp_c"
        case isDay = "is_day"
        case condition
        case windKph = "wind_kph"
    }
}

// MARK: - Location
public struct Location: Codable {
    var name: String
    var lat, lon: Double
    var localtime: String

    enum CodingKeys: String, CodingKey {
        case name, lat, lon
        case localtime
    }
}
