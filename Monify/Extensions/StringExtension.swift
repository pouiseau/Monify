//
//  StringExtension.swift
//  Monify
//
//  Created by temp on 19.10.2024.
//

import Foundation

extension String {
    func dateParse() -> Date {
        guard let parsedDate = DateFormatter.allNumericUSA.date(from: self) else { return Date() }
        
        return parsedDate
    }
}
