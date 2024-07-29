//
//  ExtenTableView.swift
//  SwiftDemo
//
//  Created by june on 2024/7/10.
//

import UIKit

extension UITableView {
    /// 會先檢查 identifier, 若未註冊會先註冊 by class
    /// - Parameters:
    ///   - identifier: identifier
    ///   - indexPath: indexPath
    /// - Returns: UITableViewCell
    private func loadFromClass(_ identifier: String, forIndexPath indexPath: IndexPath) -> UITableViewCell {
        if objc_getAssociatedObject(self, NSString(string: identifier).utf8String!) == nil && self.dequeueReusableCell(withIdentifier: identifier) == nil {
            
            self.register(NSClassFromString(identifier), forCellReuseIdentifier: identifier)
            objc_setAssociatedObject(self,
                                     NSString(string: identifier).utf8String!,
                                     NSObject(),
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return self.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
    
    /// 會先檢查 identifier, 若未註冊會先註冊 by nib
    /// - Parameters:
    ///   - identifier: identifier
    ///   - indexPath: indexPath
    /// - Returns: UITableViewCell
    private func loadFromNib(_ identifier: String, forIndexPath indexPath: IndexPath) -> UITableViewCell {
        if objc_getAssociatedObject(self, NSString(string: identifier).utf8String!) == nil && self.dequeueReusableCell(withIdentifier: identifier) == nil {
            let nib = UINib(nibName: identifier, bundle: nil)
            self.register(nib, forCellReuseIdentifier: identifier)
            objc_setAssociatedObject(self,
                                     NSString(string: identifier).utf8String!,
                                     NSObject(),
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return self.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
    
    public func cellLoadWithIdentifier(_ cellClass: AnyClass, indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: cellClass)
        if identifier == String(describing: UITableViewCell.self) {
            return self.loadFromClass(identifier, forIndexPath: indexPath)
        }
        else {
            return self.loadFromNib(identifier, forIndexPath: indexPath)
        }
    }
}
