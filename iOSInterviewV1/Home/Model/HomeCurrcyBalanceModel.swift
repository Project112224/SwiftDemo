//
//  HomeCurrcyBalanceModel.swift
//  iOSInterviewV1
//
//  Created by june on 2024/7/10.
//

import Foundation

struct HomeCurrcyBalanceModel: Decodable {
    let curr: CurrencyType
    var balance: Decimal?
    
    var balanceString: String {
        let isMask = UserDefaults.isMaskBalance
        if isMask {
            return "********"
        }
        else {
            if let balance = self.balance {
                return "\(balance)".toCurrencyFormat()
            }
            else {
                return "-"
            }
        }
    }
}
