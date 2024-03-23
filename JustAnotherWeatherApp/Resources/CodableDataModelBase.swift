//
//  CodableDataModelBase.swift
//  JustAnotherWeatherApp
//
//  Created by Rakibur Khan on 23/3/24.
//

import Foundation

class CodableDataModelBase: NSObject {
    struct CodableErrorModel: Decodable {
        let message: String?
    }
    
    struct CodableEmptyData: Decodable {
        
    }
}
