//
//  HomeCurrcyBalanceModel.swift
//  SwiftDemo
//
//  Created by june on 2024/7/10.
//

import Foundation

struct HomeCurrcyBalanceModel: Decodable {
    let curr: CurrencyType
    var balance: Decimal?
    
    var balanceString: String {
        let isMask: Bool = UserDefaults.isMaskBalance
        if isMask {
            return "********"
        } else {
            if let balance: Decimal = self.balance {
                return "\(balance)".toCurrency()
            }
            return "-"
        }
    }
}
