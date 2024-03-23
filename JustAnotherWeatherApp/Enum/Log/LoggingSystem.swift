//
//  LoggingSystem.swift
//  JustAnotherWeatherApp
//
//  Created by Rakibur Khan on 24/3/24.
//

import Foundation
import OSLog

enum LoggingSystem {
    static let ui = Logger(category: .uiFlow)
    static let data = Logger(category: .dataFlow)
    static let location = Logger(category: .location)
}
