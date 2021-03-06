//
//  APIClient.swift
//  WeatherApp
//
//  Created by Christian Hurtado on 2/3/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation
import NetworkHelper

struct WeatherAPI {
    
    static func getForecast(lat: Double, long: Double,
                            completion: @escaping (Result<[WeatherData], AppError>) -> ()) {
        let endpointKey = Secrets.weatherKey
        
        let endpointUrl = "https://api.darksky.net/forecast/\(endpointKey)/\(lat),\(long)"
        guard let url = URL(string: endpointUrl) else {
            completion(.failure(.badURL(endpointUrl)))
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let searchResults = try JSONDecoder().decode(Weather.self, from: data)
                    completion(.success(searchResults.daily.data))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
