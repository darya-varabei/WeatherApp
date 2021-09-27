//
//  Request.swift
//  NetApi
//
//  Created by Дарья Воробей on 9/27/21.
//

import Foundation
//import WeatherApp

public enum WeatherError: Error {
    case noDataAvailable
    case canNotProcessData
}

public struct WeatherRequest {

    let API_KEY = "1bdb39fb15694f4a99d202336211609"
    let API_KEY2 = "0abb6a9569d54895895515951a1a9858"
    var resourceURL: URL
    let forecastURL: URL

   public init(location: String) {

     let resurceString = "https://api.weatherapi.com/v1/forecast.json?key=\(API_KEY)&q=\(location)&days=3&aqi=no&alerts=no"
    
    let forecastString = "https://api.weatherbit.io/v2.0/forecast/daily?city=\(location)&key=\(API_KEY2)"
        guard let resourceURL = URL(string: resurceString) else {fatalError()}
    guard let forecastURL = URL(string: forecastString) else {fatalError()}

        self.resourceURL = resourceURL
    self.forecastURL = forecastURL
    
    }

    public mutating func fetchData<T: Decodable>(completion: @escaping(Result<[T], WeatherError>) -> Void) {
        
        if T.self != type(of: [Weather].self) {
            self.resourceURL = self.forecastURL
        }
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }

            do {
                let decoder = JSONDecoder()
                let weatherResponse = try decoder.decode(T.self, from: jsonData)
                let weatherDetails = weatherResponse
                completion(.success(weatherDetails as! [T]))
                //print("\(weatherDetails.forecast.forecastday)\n\n")
            } catch {
                completion(.failure((.canNotProcessData)))
            }
        }
        dataTask.resume()
    }
    
//    public func fetchForecast(completion: @escaping(Result<Welcome, WeatherError>) -> Void) {
//         let dataTask = URLSession.shared.dataTask(with: forecastURL) { data, _, _ in
//             guard let jsonData = data else {
//                 completion(.failure(.noDataAvailable))
//                 return
//             }
//
//             do {
//                 let decoder = JSONDecoder()
//                 let weatherResponse = try decoder.decode(Welcome.self, from: jsonData)
//                 let weatherDetails = weatherResponse
//                 completion(.success(weatherDetails))
//                 print("\(weatherDetails.data)\n\n")
//             } catch {
//                 completion(.failure((.canNotProcessData)))
//             }
//         }
//         dataTask.resume()
//     }
}

