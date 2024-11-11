//
//  EndpointType.swift
//  SwiftDemo
//
//  Created by june on 2024/7/10.
//

import Foundation

enum Endpoint: String {
    // Notification
    case emptyNotificationList = "6699d4ffad19ca34f889a3d4"
    case notificationList = "6699d514acd3cb34a868204c"
    // Account
    case usdSavings1 = "6699f6d2acd3cb34a8682a3d"
    case usdFixed1 = "6699f6e9e41b4d34e413ef14"
    case usdDigital1 = "6699f6f8e41b4d34e413ef1e"
    case khrSavings1 = "6699f708ad19ca34f889adc0"
    case khrFixed1 = "6699f719e41b4d34e413ef23"
    case khrDigital1 = "6699f72ee41b4d34e413ef2a"
    case usdSavings2 = "6699f746acd3cb34a8682a60"
    case usdFixed2 = "6699f755ad19ca34f889addf"
    case usdDigital2 = "6699f766ad19ca34f889ade4"
    case khrSavings2 = "6699f783acd3cb34a8682a75"
    case khrFixed2 = "6699f792e41b4d34e413ef4c"
    case khrDigital2 = "6699f7a1e41b4d34e413ef53"
    // Favorite
    case emptyFavoriteList = "6699f7b2ad19ca34f889adf9"
    case favoriteList = "6699f7c4acd3cb34a8682a88"
    // Banner
    case banner = "6699f7dfad19ca34f889ae09"
    
    var urlString: String {
        return "https://api.jsonbin.io/v3/b/\(self.rawValue)/latest"
    }
}
