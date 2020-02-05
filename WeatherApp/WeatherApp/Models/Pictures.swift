//
//  Pictures.swift
//  WeatherApp
//
//  Created by Christian Hurtado on 2/4/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation

struct Pix: Codable{
    let hits: [Pictures]
}

struct Pictures: Codable, Equatable {
    let largeImageURL: String
}
