//
//  exchangeRateModel.swift
//  ExchangeRateApp
//
//  Created by Huy on 07/01/2023.
//

import Foundation

struct ExchangeRate: Decodable {
    var result             : String?          = nil
    var documentation      : String?          = nil
    var termsOfUse         : String?          = nil
    var timeLastUpdateUnix : Int?             = nil
    var timeLastUpdateUtc  : String?          = nil
    var timeNextUpdateUnix : Int?             = nil
    var timeNextUpdateUtc  : String?          = nil
    var baseCode           : String?          = nil
    let conversionRates: [String: Double]
        
    enum CodingKeys: String, CodingKey {
        case result             = "result"
            case documentation      = "documentation"
            case termsOfUse         = "terms_of_use"
            case timeLastUpdateUnix = "time_last_update_unix"
            case timeLastUpdateUtc  = "time_last_update_utc"
            case timeNextUpdateUnix = "time_next_update_unix"
            case timeNextUpdateUtc  = "time_next_update_utc"
            case baseCode           = "base_code"
            case conversionRates    = "conversion_rates"
    }
}

typealias ExchageRates = [ExchangeRate]
