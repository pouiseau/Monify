//
//  DateFormatterExtension.swift
//  Monify
//
//  Created by temp on 19.10.2024.
//

import Foundation

extension DateFormatter {
    static let allNumericUSA: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        return formatter
    }()
}
