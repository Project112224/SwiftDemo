//
//  ExtensionString.swift
//  SwiftDemo
//
//  Created by june on 2024/7/10.
//

import Foundation

extension String {
    
    /// 依幣別轉換顯示樣式
    /// - Returns: 顯示金額
    func toCurrencyFormat() -> String {
        if let doubleValue = Double(self) {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.currencySymbol = ""
            numberFormatter.maximumFractionDigits = 2
            numberFormatter.minimumFractionDigits = 2
            numberFormatter.groupingSeparator = ","
            numberFormatter.decimalSeparator = "."
            numberFormatter.usesGroupingSeparator = true
            numberFormatter.locale = Locale(identifier: "en_US")
            
            return numberFormatter.string(from: NSNumber(value: doubleValue)) ?? ""
        }
        return ""
    }
}
