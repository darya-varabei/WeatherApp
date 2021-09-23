//
//  ApiRequest.swift
//  ApiNetwork
//
//  Created by Darya on 9/23/21.
//

import Foundation
//import WeatherApp

public enum WeatherError: Error {
    case noDataAvailable
    case canNotProcessData
}

public struct WeatherRequest {
    let resourceURL: URL
    let API_KEY = "1bdb39fb15694f4a99d202336211609"

   public init(location: String) {

        let resurceString = "https://api.weatherapi.com/v1/forecast.json?key=\(API_KEY)&q=Minsk&days=7&aqi=no&alerts=no"
        guard let resourceURL = URL(string: resurceString) else {fatalError()}

        self.resourceURL = resourceURL
    }

   public func fetchData(completion: @escaping(Result<Weather, WeatherError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }

            do {
                let decoder = JSONDecoder()
                let weatherResponse = try decoder.decode(Weather.self, from: jsonData)
                let weatherDetails = weatherResponse
                completion(.success(weatherDetails))
            } catch {
                completion(.failure((.canNotProcessData)))
            }
        }
        dataTask.resume()
    }
}

