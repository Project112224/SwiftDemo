//
//  EndpointType.swift
//  SwiftDemo
//
//  Created by june on 2024/7/10.
//

import Foundation

enum Endpoint: String {
    // Notification
    case emptyNotificationList
    case notificationList
    // Account
    case usdSavings1
    case usdFixed1
    case usdDigital1
    case khrSavings1
    case khrFixed1
    case khrDigital1
    case usdSavings2
    case usdFixed2
    case usdDigital2
    case khrSavings2
    case khrFixed2
    case khrDigital2
    // Favorite
    case emptyFavoriteList
    case favoriteList
    // Banner
    case banner
    
    var urlString: String {
        return "https://willywu0201.github.io/data/\(self.rawValue).json"
    }
}
