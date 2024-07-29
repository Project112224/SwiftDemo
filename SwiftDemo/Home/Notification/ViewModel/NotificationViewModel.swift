//
//  NotificationViewModel.swift
//  SwiftDemo
//
//  Created by june on 2024/7/10.
//

import Foundation

class NotificationViewModel {
    
    struct Input {}
    
    struct Output {
        let initNotificationResponse: CustomSubject<Bool>
    }
    
    var notificationList: [NotificationMessageModel]
    
    init(data: [NotificationMessageModel]) {
        self.notificationList = data
    }
    
    func transfer(input: Input) -> Output {
        
        let notificationResponse = CustomSubject<Bool>()
        Task {
            await self.fetchNotificationList(onNext: { [weak self] list in
                guard let `self` = self else { return }
                self.notificationList = list
                notificationResponse.send(true)
            })
        }
        
        return Output(initNotificationResponse: notificationResponse)
    }
}

extension NotificationViewModel {
    
    private func fetchNotificationList(onNext: ([NotificationMessageModel])->()) async {
        await NotificationService.queryList { list in
            onNext(list ?? [])
        } onError: { error in
            print("error")
        }
    }
    
}
