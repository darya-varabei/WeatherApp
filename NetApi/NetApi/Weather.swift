//
//  Weather.swift
//  NetApi
//
//  Created by Дарья Воробей on 9/27/21.
//

import Foundation

// MARK: - Weather
public struct Weather: Codable {
    public var location: Location
    public var current: Current
    public var forecast: Forecast
}

// MARK: - Current
public struct Current: Codable {
    public var lastUpdated: String
    public var tempC: Double
    public var condition: Condition
    public var windKph: Double

    public enum CodingKeys: String, CodingKey {
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case condition
        case windKph = "wind_kph"
    }
}

// MARK: - Condition
public struct Condition: Codable {
    public var code: Int
    public var text: String
}

// MARK: - Forecast
public struct Forecast: Codable {
    public var forecastday: [Forecastday]
}

// MARK: - Forecastday
public struct Forecastday: Codable {
    public var date: String
    public var day: Day
    public var hour: [Hour]

    public enum CodingKeys: String, CodingKey {
        case date
        case day, hour
    }
}

// MARK: - Day
public struct Day: Codable {
    public var maxtempC, mintempC: Double
    public var maxwindKph: Double
    public var condition: Condition

    public enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
        case maxwindKph = "maxwind_kph"
        case condition
    }
}

// MARK: - Hour
public struct Hour: Codable {
    public var time: String
    public var tempC: Double
    public var condition: Condition
    public var windKph: Double

    public enum CodingKeys: String, CodingKey {
        case time
        case tempC = "temp_c"
        case condition
        case windKph = "wind_kph"
    }
}

// MARK: - Location
public struct Location: Codable {
    public var name: String
    public var localtime: String

    public enum CodingKeys: String, CodingKey {
        case name
        case localtime
    }
}

