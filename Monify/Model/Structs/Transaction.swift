//
//  Transaction.swift
//  Monify
//
//  Created by temp on 19.10.2024.
//

import Foundation

struct Transaction: Identifiable, Decodable, Hashable {
    let id: Int
    let date: String
    let institution: String
    let account: String
    var merchant: String
    let amount: Double
    let type: TransactionType.RawValue
    var categoryId: Int
    var category: String
    let isPending: Bool
    var isTransfer: Bool
    var isExpense: Bool
    var isEdited: Bool
    
    var dateParsed: Date {
        date.dateParse()
    }
    
    var signedAmount: Double {
        type == TransactionType.credit.rawValue
        ? amount
        : -amount
    }
}
