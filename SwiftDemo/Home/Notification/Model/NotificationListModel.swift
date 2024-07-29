//
//  NotificationListModel.swift
//  SwiftDemo
//
//  Created by june on 2024/7/10.
//

import Foundation

struct NotificationModel: Decodable {
    let messages: [NotificationMessageModel]?
}

struct NotificationMessageModel: Decodable {
    let status: Bool
    let updateDateTime: String
    let title: String
    let message: String
}
