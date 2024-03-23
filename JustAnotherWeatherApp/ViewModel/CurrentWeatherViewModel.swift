//
//  CurrentWeatherViewModel.swift
//  JustAnotherWeatherApp
//
//  Created by Rakibur Khan on 23/3/24.
//

import Foundation

final class CurrentWeatherViewModel: ObservableObject {
    @Published var currentWeather: Weather?
    @Published var currentWeatherData: Temperature?
    
    let apiService: WeatherAPIService = .init()
    
    func fetchCurrentWeather(lat: Double, lon: Double) async {
        let reply = await apiService.currentWeather(lat: lat, lon: lon)
        
        switch reply {
            case .success(let data):
                await MainActor.run {
                    self.currentWeather = data
                    self.currentWeatherData = data.temperature
                }
                
            case .failure(let error):
                print(error)
        }
    }
}
