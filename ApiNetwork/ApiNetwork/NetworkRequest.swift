//
//  NetworkRequest.swift
//  ApiNetwork
//
//  Created by Darya on 9/21/21.
//

import Foundation
import UIKit

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) -> ModelType?
    func execute(withCompletion completion: @escaping (ModelType?) -> Void)
}

extension NetworkRequest {
    fileprivate func load(_ url: URL, withCompletion completion: @escaping (ModelType?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _ , _) -> Void in
            guard let data = data, let value = self?.decode(data) else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            DispatchQueue.main.async { completion(value) }
        }
        task.resume()
    }
}

class APIRequest<Resource: APIResource> {
    let resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }
}

extension APIRequest: NetworkRequest {
    func decode(_ data: Data) -> [Resource.ModelType]? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let wrapper = try? decoder.decode(Wrapper<Resource.ModelType>.self, from: data)
        return wrapper?.items
    }
    
    func execute(withCompletion completion: @escaping ([Resource.ModelType]?) -> Void) {
        load(resource.url, withCompletion: completion)
    }
}

// MARK: - APIResource
protocol APIResource {
    associatedtype ModelType: Decodable
    var methodPath: String { get }
    var filter: String? { get }
}

extension APIResource {
    var url: URL {
        var components = URLComponents(string: "http://api.weatherapi.com/v1/forecast.json?key=1bdb39fb15694f4a99d202336211609")!
        components.path = methodPath
        components.queryItems = [
            URLQueryItem(name: "&q=", value: "London"),
            URLQueryItem(name: "&days=", value: "7"),
            URLQueryItem(name: "aqi=", value: "no"),
            URLQueryItem(name: "alerts=", value: "no"),
            //URLQueryItem(name: "pagesize=", value: "10")
        ]
        if let filter = filter {
            components.queryItems?.append(URLQueryItem(name: "filter", value: filter))
        }
        return components.url!
    }
}

