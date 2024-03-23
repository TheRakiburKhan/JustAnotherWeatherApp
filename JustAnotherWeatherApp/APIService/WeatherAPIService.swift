//
//  WeatherAPIService.swift
//  JustAnotherWeatherApp
//
//  Created by Rakibur Khan on 22/3/24.
//

import Foundation

final class WeatherAPIService: CodableDataModelBase, API {
    private var decoder: JSONDecoder
    
    override init() {
        decoder = .init()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func currentWeather(lat: Double, lon: Double) async -> Result<Weather, Error>  {
        do {
            guard let rawData: CodableCurrentWeatherDataModel = try await parseResponse(from: URLS.Weather.currentWeather(lat: lat, lon: lon).url, decoder: decoder) else {
                throw URLError(.cannotDecodeRawData)
            }
            
            let returnData: Weather = .init(rawData)
            
            return .success(returnData)
        } catch {
            
            return .failure(error)
        }
    }
    
}

fileprivate extension Weather {
    init(_ data: CodableDataModelBase.CodableCurrentWeatherDataModel) {
        self.init(title: data.weather.first?.main ?? "", description: data.weather.first?.description ?? "", icon: buildImageURL(iconName: data.weather.first?.icon ?? ""), temperature: .init(data.main), wind: .init(data.wind), name: data.name, sunrise: Date(timeIntervalSince1970: TimeInterval(data.sys.sunrise)), sunset: Date(timeIntervalSince1970: TimeInterval(data.sys.sunset)), visibility: data.visibility)
    }
}

fileprivate extension Temperature {
    init(_ data: CodableDataModelBase.CodableMain) {
        self.init(temperature: data.temp, tempFeelsLike: data.feelsLike, temMinimum: data.tempMin, tempMaximum: data.tempMax, pressure: data.pressure, humidity: data.humidity)
    }
}

fileprivate extension Wind {
    init(_ data: CodableDataModelBase.CodableWind) {
        self.init(speed: data.speed, angle: data.deg)
    }
}

fileprivate extension CodableDataModelBase {
    // MARK: - CurrentWeatherDataModel
    struct CodableCurrentWeatherDataModel: Codable {
        let coord: CodableCoord
        let weather: [CodableWeather]
        let base: String
        let main: CodableMain
        let visibility: Double
        let wind: CodableWind
        let clouds: CodableClouds
        let dt: Int
        let sys: CodableSys
        let timezone: Int
        let id: Int
        let name: String
        let cod: Int
    }

    // MARK: - Clouds
    struct CodableClouds: Codable {
        let all: Int
    }

    // MARK: - Coord
    struct CodableCoord: Codable {
        let lon: Double
        let lat: Double
    }

    // MARK: - Main
    struct CodableMain: Codable {
        let temp: Double
        let feelsLike: Double
        let tempMin: Double
        let tempMax: Double
        let pressure: Double
        let humidity: Double
    }

    // MARK: - Sys
    struct CodableSys: Codable {
        let id: Int?
        let type: Int?
        let country: String?
        let sunrise: Int
        let sunset: Int
    }

    // MARK: - Weather
    struct CodableWeather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }

    // MARK: - Wind
    struct CodableWind: Codable {
        let speed: Double
        let deg: Double
    }
}
