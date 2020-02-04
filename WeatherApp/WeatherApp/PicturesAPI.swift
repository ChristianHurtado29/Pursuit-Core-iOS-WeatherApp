//
//  PicturesAPI.swift
//  WeatherApp
//
//  Created by Christian Hurtado on 2/4/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation
import UIKit
import NetworkHelper

struct PicturesAPI {

static func loadPictures(for searchQuery: String,
                          completion: @escaping (Result<[Pictures], AppError>) -> ()) {
        
    let apiKey = "14968421-bdbbdb0f044ae1bfcb38ea89d&q"
    
        let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "yellow"
        
    let picturesEndpointURL = "https://pixabay.com/api/?key=\(apiKey)=\(searchQuery.lowercased())&image_type=photo"
        
            guard let url = URL(string: picturesEndpointURL) else {
            completion(.failure(.badURL(picturesEndpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let searchResults = try JSONDecoder().decode(Pix.self, from: data)
                    let picReturns = searchResults.hits
                    dump(picReturns)
                    completion(.success(picReturns))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
