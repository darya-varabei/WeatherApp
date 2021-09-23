//
//  WeatherModel.swift
//  ApiNetwork
//
//  Created by Darya on 9/23/21.
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
    public var isDay: Int
    public var condition: Condition
    public  var windKph: Double

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

    enum CodingKeys: String, CodingKey {
        case date
        case day, hour
    }
}

// MARK: - Day
public struct Day: Codable {
    public var maxtempC, mintempC: Double
    public var maxwindKph: Double
    public var condition: Condition

    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
        case maxwindKph = "maxwind_kph"
        case condition
    }
}

// MARK: - Hour
public struct Hour: Codable {
    public  var time: String
    public var tempC: Double
    public var isDay: Int
    public var condition: Condition
    public var windKph: Double

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
    public var name: String
    public var lat, lon: Double
    public var localtime: String

    enum CodingKeys: String, CodingKey {
        case name, lat, lon
        case localtime
    }
}

