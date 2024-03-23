//
//  API.swift
//  JustAnotherWeatherApp
//
//  Created by Rakibur Khan on 22/3/24.
//

import Foundation
import RKAPIUtility
import OSLog

protocol API {
    func parseResponse<T: Decodable>(from url: URL?, additionalHeader: [Header]?, decoder: JSONDecoder, logger: Logger?) async throws -> T?
    
    func parseResponse<T: Decodable, E: Encodable>(from url: URL?, httpMethod: HTTPMethod, body: E, additionalHeader: [Header]?, decoder: JSONDecoder, logger: Logger?) async throws -> T?
    
    func parseResponse<T: Decodable>(from url: URL?, httpMethod: HTTPMethod, body: Data?, additionalHeader: [Header]?, decoder: JSONDecoder, logger: Logger?) async throws -> T?
}

extension API {
    func parseResponse<T: Decodable>(from url: URL?, additionalHeader: [Header]? = nil, decoder: JSONDecoder = .init(), logger: Logger? = nil) async throws -> T? {
        do {
            let reply = try await rkapiService.fetchItems(urlLink: url, additionalHeader: additionalHeader)
            
            guard let rawData = reply.data else { throw reply.response }
            
            guard reply.response.responseType == .success else {
                if let logger = logger {
                    logger.trace("Data: \(String(decoding: rawData, as: UTF8.self))\nResponse: \(reply.response)")
                }
                
                throw reply.response
            }
            
            let decodedData = try decoder.decode(T.self, from: rawData)
            
            return decodedData
        } catch {
            if let logger = logger {
                logger.error("\(error)")
            }
            
            throw error
        }
    }
    
    func parseResponse<T: Decodable, E: Encodable>(from url: URL?, httpMethod: HTTPMethod = .post, body: E, additionalHeader: [Header]? = nil, decoder: JSONDecoder = .init(), logger: Logger? = nil) async throws -> T? {
        do {
            let reply = try await rkapiService.fetchItemsByHTTPMethod(urlLink: url, httpMethod: httpMethod, body: body, additionalHeader: additionalHeader)
            
            guard let rawData = reply.data else { throw reply.response }
            
            guard reply.response.responseType == .success else {
                if let logger = logger {
                    logger.trace("Data: \(String(decoding: rawData, as: UTF8.self))\nResponse: \(reply.response)")
                }
                
                throw reply.response
            }
            
            let decodedData = try decoder.decode(T.self, from: rawData)
            
            return decodedData
        } catch {
            if let logger = logger {
                logger.error("\(error)")
            }
            
            throw error
        }
    }
    
    func parseResponse<T: Decodable>(from url: URL?, httpMethod: HTTPMethod = .post, body: Data?, additionalHeader: [Header]? = nil, decoder: JSONDecoder = .init(), logger: Logger? = nil) async throws -> T? {
        do {
            let reply = try await rkapiService.fetchItemsByHTTPMethod(urlLink: url, httpMethod: httpMethod, body: body, additionalHeader: additionalHeader)
            
            guard let rawData = reply.data else { throw reply.response }
            
            guard reply.response.responseType == .success else {
                if let logger = logger {
                    logger.trace("Data: \(String(decoding: rawData, as: UTF8.self))\nResponse: \(reply.response)")
                }
                
                throw reply.response
            }
            
            let decodedData = try decoder.decode(T.self, from: rawData)
            
            return decodedData
        } catch {
            if let logger = logger {
                logger.error("\(error)")
            }
            
            throw  error
        }
    }
}
