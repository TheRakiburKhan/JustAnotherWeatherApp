//
//  WeatherSummaryView.swift
//  JustAnotherWeatherApp
//
//  Created by Rakibur Khan on 24/3/24.
//

import SwiftUI

struct WeatherSummaryView: View {
    var weather: Weather
    var body: some View {
        Text("Hello, World!")
    }
}

//#if DEBUG
struct WeatherSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherSummaryView(weather: .mock1)
    }
}
//#endif
