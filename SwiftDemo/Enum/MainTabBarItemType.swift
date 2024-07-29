//
//  MainTabBarItemType.swift
//  SwiftDemo
//
//  Created by june on 2024/7/13.
//

import UIKit

enum MainTabBarItemType: String, CaseIterable {
    /// 首頁
    case home = "Home"
    /// 帳戶頁
    case account = "Account"
    /// 地圖所在頁
    case location = "Location"
    /// 服務項目頁
    case service = "Service"
    
    var imageName: String {
        switch self {
        case .home:
            return "main_tabbar_icon_home"
        case .account:
            return "main_tabbar_icon_account"
        case .location:
            return "main_tabbar_icon_location"
        case .service:
            return "main_tabbar_icon_service"
        }
    }
    
    var controller: UIViewController {
        switch self {
        case .home:
            return HomeViewController()
        case .account:
            return AccountViewController()
        case .location:
            return LocationViewController()
        case .service:
            return ServiceViewController()
        }
    }
}
