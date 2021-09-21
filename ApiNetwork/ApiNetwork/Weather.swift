//
//  Weather.swift
//  ApiNetwork
//
//  Created by Darya on 9/21/21.
//

import Foundation
import UIKit

struct Condition {
    let text: String
}

struct Day {
    let temp_c: Double
    let wind_mph: Double
    let condition: Condition
}

struct Location {
    let name: String
    let country: String
    let localtime: String
}

//struct DayForecast {
//    let maxtemp_c: Double
//    let mintemp_c: Double
//    let condition: Condition
//}

struct ForecastDay {
    let date: String
    let forecastday: DayForecast
}

struct Hour {
    let time: String
    let temp_c: Double
    let wind_mph: Double
    let condition: Condition
    let time: string
}
