//
//  Weather.swift
//  JustAnotherWeatherApp
//
//  Created by Rakibur Khan on 23/3/24.
//

import Foundation

struct Weather {
    let title: String
    let description: String
    let icon: URL?
    let temperature: Temperature
    let wind: Wind
    let name: String?
    let sunrise: Date?
    let sunset: Date?
    let visibility: Double
}
