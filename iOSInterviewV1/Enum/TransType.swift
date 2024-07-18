//
//  TransType.swift
//  iOSInterviewV1
//
//  Created by june on 2024/7/10.
//

import Foundation

enum TransType: String {
    case cubc = "CUBC"
    case mobile = "Mobile"
    case pmf = "PMF"
    case creditCard = "CreditCard"
    
    var imageName: String {
        switch self {
        case .cubc:
            return "home_favorite_icon_cubc"
        case .mobile:
            return "home_favorite_icon_mobile"
        case .pmf:
            return "home_favorite_icon_pmf"
        case .creditCard:
            return "home_favorite_icon_creditCard"
        }
    }
}
