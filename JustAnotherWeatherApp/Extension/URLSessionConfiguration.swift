//
//  URLSessionConfiguration.swift
//  JustAnotherWeatherApp
//
//  Created by Rakibur Khan on 23/3/24.
//

import Foundation

public extension URLSessionConfiguration {
    class func openWeather() -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.allowsCellularAccess = true
        configuration.allowsConstrainedNetworkAccess = true
        configuration.allowsExpensiveNetworkAccess = true
        configuration.networkServiceType = .responsiveData
        configuration.waitsForConnectivity = true
        configuration.httpAdditionalHeaders = [
            "X-User-Agent": "iPhone",
            "Accept": "application/json",
            "Content-Type": "application/json",
        ]
        configuration
        
        return configuration
    }
}
