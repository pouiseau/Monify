//
//  DateExtension.swift
//  Monify
//
//  Created by temp on 16.11.2024.
//

import Foundation

extension Date: Strideable {
    func formatted() -> String {
        return self.formatted(.dateTime.year().month().day())
    }
}
