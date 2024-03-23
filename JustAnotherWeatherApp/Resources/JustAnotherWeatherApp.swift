//
//  JustAnotherWeatherApp.swift
//  JustAnotherWeatherApp
//
//  Created by Rakibur Khan on 21/3/24.
//

import SwiftUI
import RKAPIService

@main
struct JustAnotherWeatherApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

@MainActor
let utility: Utility = .init()
let rkapiService: RKAPIService = RKAPIService(sessionConfiguration: .openWeather(), delegate: nil, queue: nil)
