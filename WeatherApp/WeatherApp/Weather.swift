//
//  Weather.swift
//  WeatherApp
//
//  Created by Christian Hurtado on 2/3/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let latitude: Double
    let longitude: Double
    let daily: Daily
}

struct Daily: Codable {
    let summary: String
    let data: [Data]
}

struct Data: Codable {
    let time: Int
    let sunriseTime: Int
    let sunsetTime: Int
    let icon: String
    let precipType: String
    let temperatureHigh: Double
    let temperatureLow: Double
}
