//
//  BannerService.swift
//  SwiftDemo
//
//  Created by june on 2024/7/17.
//

import Foundation

class BannerService {
    
    static func queryList(onNext: ([HomeAdBannerInfoModel])->(), onError: ((Error)->())? = nil) async {
        let result = await NetworkManager.get(endpoint: .banner, model: HomeAdBannerModel.self)
        switch result {
        case .success(let model):
            onNext(model.result.bannerList)
        case .failure(let error):
            onError?(error)
        }
    }
    
}
