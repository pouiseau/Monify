//
//  DateExtension.swift
//  Monify
//
//  Created by temp on 16.11.2024.
//

import Foundation

extension Date {
    func formatted() -> String {
        return self.formatted(.dateTime.weekday(.abbreviated))
    }
}
