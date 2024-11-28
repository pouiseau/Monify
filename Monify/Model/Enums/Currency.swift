//
//  Currency.swift
//  Monify
//
//  Created by temp on 17.11.2024.
//

import Foundation

enum Currency: String, Decodable, Encodable, CaseIterable {
    case USD = "USD" // US Dollar
    case EUR = "EUR" // Euro
    case CZK = "CZK" // Czech Koruna
    case GBP = "GBP" // British Pound
    case JPY = "JPY" // Japanese Yen
    case AUD = "AUD" // Australian Dollar
    case CAD = "CAD" // Canadian Dollar
    case CHF = "CHF" // Swiss Franc
    
    
    var symbol: String {
        switch self {
            case .USD: return "$"
            case .EUR: return "€"
            case .CZK: return "Kč"
            case .GBP: return "£"
            case .JPY: return "¥"
            case .AUD: return "A$"
            case .CAD: return "C$"
            case .CHF: return "CHF"
        }
    }
    var fullName: String {
        switch self {
            case .USD: return "US Dollar"
            case .EUR: return "Euro"
            case .CZK: return "Czech Koruna"
            case .GBP: return "British Pound"
            case .JPY: return "Japanese Yen"
            case .AUD: return "Australian Dollar"
            case .CAD: return "Canadian Dollar"
            case .CHF: return "Swiss Franc"
        }
    }
}
