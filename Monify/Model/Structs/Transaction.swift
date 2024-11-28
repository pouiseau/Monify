//
//  Transaction.swift
//  Monify
//
//  Created by temp on 19.10.2024.
//

import Foundation
import SwiftUIFontIcon

struct Transaction: Identifiable, Decodable, Encodable, Hashable {
    let id: Int
    let date: String
    let amount: Double
    var currency: Currency
    var categoryId: Int
    var category: String
    var isExpense: Bool
    
    var icon: FontAwesomeCode {
        if let category = Category.all.first(where: {$0.id == categoryId }) {
            return category.icon
        }
        
        return .question
    }
    
    var dateParsed: Date {
        date.dateParse()
    }
    
    var signedAmount: Double {
        !isExpense ? amount : -amount
    }
    
    func amountInUSD(exchangeRate: Double) -> Double {
        return signedAmount / exchangeRate
    }
    
    var month: String {
        dateParsed.formatted(.dateTime.year().month(.wide))
    }
}
