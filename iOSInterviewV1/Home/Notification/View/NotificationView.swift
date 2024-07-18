//
//  NotificationView.swift
//  iOSInterviewV1
//
//  Created by june on 2024/7/18.
//

import UIKit

extension NotificationViewController {
    
    func layoutUI() {
        self.view.addSubview(self.tableView)
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ])
    }
    
    
}
