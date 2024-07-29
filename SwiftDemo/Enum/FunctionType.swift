//
//  FunctionType.swift
//  SwiftDemo
//
//  Created by june on 2024/7/10.
//

import Foundation

enum FunctionType: String, CaseIterable {
    case transfer = "Transfer"
    case payment = "Payment"
    case utility = "Utility"
    case qrPayScan = "QR pay scan"
    case myQRCode = "My QR code"
    case topUp = "Top up"
    
    var imageName: String {
        switch self {
        case .transfer:
            return "home_functionList_icon_transfer"
        case .payment:
            return "home_functionList_icon_payment"
        case .utility:
            return "home_functionList_icon_utility"
        case .qrPayScan:
            return "home_functionList_icon_scan"
        case .myQRCode:
            return "home_functionList_icon_qrCode"
        case .topUp:
            return "home_functionList_icon_topUp"
        }
    }
}
