//
//  URLS.swift
//  JustAnotherWeatherApp
//
//  Created by Rakibur Khan on 23/3/24.
//

import Foundation
import RKAPIUtility

fileprivate struct Key: Decodable {
    let baseURL: String
    let baseURLImage: String
    let scheme: String
    let schemeImage: String
    let appId: String
    
    private enum CodingKeys: String, CodingKey {
        case baseURL = "base_url"
        case baseURLImage = "base_url_image"
        case scheme = "scheme"
        case schemeImage = "scheme_image"
        case appId = "app_id"
    }
}

enum URLInfoRetreaver {
    case baseURL
    case baseURLImage
    case scheme
    case schemeImage
    case appId
    
    var stringValue: String {
        return retreveKey(key: self)
    }
}

private func retreveKey(key: URLInfoRetreaver) -> String {
    let decoder = PropertyListDecoder()
    
    guard let url = Bundle.main.url(forResource: "URLInfo", withExtension: "plist") else {return ""}
    
    if let data = try? Data(contentsOf: url) {
        
        if let settings = try? decoder.decode(Key.self, from: data) {
            switch key {
                case .baseURL:
                    return settings.baseURL
                case .baseURLImage:
                    return settings.baseURLImage
                case .scheme:
                    return settings.scheme
                case .schemeImage:
                    return settings.schemeImage
                case .appId:
                    return settings.appId
            }
        }
    }
    
    return ""
}

fileprivate func buildURL(scheme: String = URLInfoRetreaver.scheme.stringValue, baseURL: String = URLInfoRetreaver.baseURL.stringValue, path: String?, query: [URLQueryItem]? = nil) -> URL? {
    var queryItems: [URLQueryItem] = [.init(name: "appid", value: "\(URLInfoRetreaver.appId.stringValue)")]
    
    if let query = query {
        queryItems.append(contentsOf: query)
    }
    
    return RKAPIHelper.buildURL(scheme: scheme, baseURL: baseURL, path: path, queries: queryItems)
}

func buildImageURL(scheme: String = URLInfoRetreaver.schemeImage.stringValue, baseURL: String = URLInfoRetreaver.baseURLImage.stringValue, path: String) -> URL? {
    
    return RKAPIHelper.buildURL(scheme: scheme, baseURL: baseURL, path: path, queries: nil)
}

func buildImageURL(iconName: String) -> URL? {
    
    return buildImageURL(path: "img/wn/\(iconName)@2x.png")
}

enum URLS {
    enum Weather: Endpoint {
        case currentWeather(lat: Double, lon: Double)
        
        var url: URL? {
            switch self {
                case .currentWeather(let lat, let lon):
                    let query: [URLQueryItem] = [
                        .init(name: "lat", value: "\(lat)"),
                        .init(name: "lon", value: "\(lon)"),
                    ]
                    
                    return buildURL(path: "data/2.5/weather", query: query)
            }
        }
    }
}
