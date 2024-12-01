//
//  Int+formattedCurrency.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 01/12/2024.
//

import Foundation

extension Int {
    func formattedCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}

