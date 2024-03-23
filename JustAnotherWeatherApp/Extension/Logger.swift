//
//  Logger.swift
//  JustAnotherWeatherApp
//
//  Created by Rakibur Khan on 24/3/24.
//

import Foundation
import OSLog

extension Logger {
    init(category: LoggerCategory) {
        self.init(subsystem: "me.therakiburkhan.app.JustAnotherWeatherApp", category: category.rawValue)
    }
}
