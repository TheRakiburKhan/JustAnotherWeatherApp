//
//  CurrentWeatherView.swift
//  JustAnotherWeatherApp
//
//  Created by Rakibur Khan on 23/3/24.
//

import SwiftUI

struct CurrentWeatherView: View {
    @Environment(\.refresh) private var refresh
    @State private var isCurrentlyRefreshing = false
    @StateObject var viewModel: CurrentWeatherViewModel = .init()
    
    let amountToPullBeforeRefreshing: CGFloat = 180
    
    var body: some View {
        ScrollView {
            LazyVStack {
                AsyncImage(url: viewModel.currentWeather?.icon) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Image(systemName: "thermometer.high")
                        .resizable()
                        .scaledToFit()
                }
                .frame(width: 200, height: 200)
                
                Text(viewModel.currentWeather?.name ?? "----")
                
                Text(viewModel.currentWeatherData?.temperature.temperature() ?? "--")
                
                Text(viewModel.currentWeather?.title ?? "--")
                
                HStack {
                    VStack {
                        Text("Wind Speed")
                        
                        Text(viewModel.currentWeather?.wind.speed.windSpeed() ?? "--")
                    }
                    
                    VStack {
                        Text("Humidity")
                        
                        Text(viewModel.currentWeatherData?.humidity.percentage() ?? "--")
                    }
                }
                
            }
            // the geometry proxy allows us to detect how far on the list we have scrolled
            // and will update the ViewOffsetKey once the "if" conditions are met
            .overlay(GeometryReader { geo in
                let currentScrollViewPosition = -geo.frame(in: .global).origin.y
                
                if currentScrollViewPosition < -amountToPullBeforeRefreshing && !isCurrentlyRefreshing {
                    Color.clear.preference(key: ViewOffsetKey.self, value: -geo.frame(in: .global).origin.y)
                }
            })
        }
        // The onPreferenceChange listens for the ViewOffsetKey to change to know when to run the pull to refresh method
        .onPreferenceChange(ViewOffsetKey.self) { scrollPosition in
            if scrollPosition < -amountToPullBeforeRefreshing && !isCurrentlyRefreshing {
                isCurrentlyRefreshing = true
                Task {
                    await refreshData()
                    await MainActor.run {
                        isCurrentlyRefreshing = false
                    }
                }
            }
        }
        .task {
            await fetchCurrentWeatherData()
        }
    }
    
    func refreshData() async {
        await fetchCurrentWeatherData()
    }
    
    func fetchCurrentWeatherData() async {
        if let location = await LocationService.shared.getCurrentLocation() {
            await viewModel.fetchCurrentWeather(lat: location.latitude, lon: location.longitude)
        }
    }
}

struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView()
    }
}
