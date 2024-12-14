//
//  Category.swift
//  Monify
//
//  Created by temp on 05.11.2024.
//

import Foundation
import SwiftUIFontIcon

struct Category {
    let id: Int
    let name: String
    let icon: FontAwesomeCode
    var mainCategoryId: Int?
}

extension Category {
    static let uncategorized = Category (id: 0, name: "Uncategorized", icon: .question)
    static let autoAndTransport = Category (id: 1, name: "Auto & Transport", icon: .car_alt)
    static let billsAndUtilities = Category(id: 2, name: "Bills & Utilities", icon: .file_invoice_dollar)
    static let entertainment = Category (id: 3, name: "Entertainment", icon: .film)
    static let feesAndCharges = Category(id: 4, name: "Fees & Charges", icon: .hand_holding_usd)
    static let foodAndDining = Category(id: 5, name: "Food & Dining", icon: .hamburger)
    static let home = Category (id: 6, name: "Home", icon: .home)
    static let salary = Category(id: 7, name: "Salary", icon: .dollar_sign)
    static let shopping = Category(id: 8, name: "Shopping", icon: . shopping_cart)
    static let transfer = Category(id: 9, name: "Transfer", icon: . exchange_alt)
}

extension Category {
    static let categories: [Category] = [
        .uncategorized,
        .autoAndTransport,
        .billsAndUtilities,
        .entertainment,
        .feesAndCharges,
        .foodAndDining,
        .home,
        .salary,
        .shopping,
        .transfer
    ]
    
    static let expenses: [Category] = [
        .uncategorized,
        .autoAndTransport,
        .billsAndUtilities,
        .entertainment,
        .feesAndCharges,
        .foodAndDining,
        .home,
        .shopping,
        .transfer
    ]
    
    static let incomes: [Category] = [
        .uncategorized,
        .salary,
        .transfer
    ]
    
    static let all: [Category] = categories
}
