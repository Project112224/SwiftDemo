//
//  NotificationService.swift
//  SwiftDemo
//
//  Created by june on 2024/7/17.
//

import Foundation

class NotificationService {
    
    /// Empty Notification List
    static func emptyList(onNext: ([NotificationMessageModel]?)->(), onError: ((Error)->())? = nil) async {
        let result = await NetworkManager.getMethod(endpoint: .emptyNotificationList, model: NotificationModel.self)
        switch result {
        case .success(_):
            onNext(nil)
        case .failure(let error):
            onError?(error)
        }
    }
    
    /// Not Empty Notification List
    static func queryList(onNext: ([NotificationMessageModel]?)->(), onError: ((Error)->())? = nil) async {
        let result = await NetworkManager.getMethod(endpoint: .notificationList, model: NotificationModel.self)
        switch result {
        case .success(let model):
            onNext(model.result.messages)
        case .failure(let error):
            onError?(error)
        }
    }
    
}
