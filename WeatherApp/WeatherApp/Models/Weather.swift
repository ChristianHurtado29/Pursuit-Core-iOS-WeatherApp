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
    let data: [Data]
}

struct Data: Codable {
    let summary: String
    let time: Int
    let sunriseTime: Int
    let sunsetTime: Int
    let icon: String
    let windSpeed: Double
    let precipType: String
    let temperatureHigh: Double
    let temperatureLow: Double
}
