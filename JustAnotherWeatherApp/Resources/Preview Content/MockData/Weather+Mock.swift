//
//  Weather+Mock.swift
//  JustAnotherWeatherApp
//
//  Created by Rakibur Khan on 24/3/24.
//

import Foundation

extension Weather {
    static var mock1: Self {
        .init(title: "Haze", description: "haze", icon: buildImageURL(iconName: "50d"), temperature: .mock1, wind: .mock1, name: "Dhaka", sunrise: Date(timeIntervalSince1970: TimeInterval(1711065625)), sunset: Date(timeIntervalSince1970: TimeInterval(1711109410)), visibility: 1000)
    }
}
