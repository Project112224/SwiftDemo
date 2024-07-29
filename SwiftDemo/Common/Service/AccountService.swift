//
//  AccountService.swift
//  SwiftDemo
//
//  Created by june on 2024/7/17.
//

import Foundation

class AccountService {
    
    static func queryBalance(apiList: [Endpoint], onNext: ([HomeAccountBalanceModel?])->(), onError: ((Error)->())? = nil) async {
        do {
            let response = try await withThrowingTaskGroup(of: HomeAccountBalanceModel?.self) { group in
                var list: [HomeAccountBalanceModel?] = []
                
                for endpoint in apiList {
                    group.addTask {
                        let result = await NetworkManager.getMethod(endpoint: endpoint, model: HomeAccountBalanceModel.self)
                        switch result {
                        case .success(let model):
                            return model.result
                        case .failure(let error):
                            throw error
                        }
                    }
                }
                
                for try await model in group {
                    list.append(model)
                }
                
                return list
            }
            onNext(response)
        } catch {
            onError?(error)
        }
    }
}
