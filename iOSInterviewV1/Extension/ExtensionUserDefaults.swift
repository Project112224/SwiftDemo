//
//  ExtensionUserDefaults.swift
//  iOSInterviewV1
//
//  Created by june on 2024/7/10.
//

import Foundation

extension UserDefaults {
    enum UserDefaultsKey: String {
        case isMaskBalance
    }
    
    static var isMaskBalance: Bool {
        get {
            return UserDefaults.standard.bool(forKey: UserDefaultsKey.isMaskBalance.rawValue)
        }
        set(value) {
            UserDefaults.standard.set(value, forKey: UserDefaultsKey.isMaskBalance.rawValue)
        }
    }
}
