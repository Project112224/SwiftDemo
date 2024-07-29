//
//  FavoriteService.swift
//  SwiftDemo
//
//  Created by june on 2024/7/18.
//

import Foundation

class FavoriteService {
    
    static func emptyList(onNext: (HomeFavoriteModel?)->(), onError: ((Error)->())? = nil) async {
        let result = await NetworkManager.get(endpoint: .emptyFavoriteList, model: BaseResultModel.self)
        switch result {
        case .success(_):
            onNext(nil)
        case .failure(let error):
            onError?(error)
        }
    }
    
    static func queryList(onNext: (HomeFavoriteModel?)->(), onError: ((Error)->())? = nil) async {
        let result = await NetworkManager.get(endpoint: .favoriteList, model: HomeFavoriteModel.self)
        switch result {
        case .success(let model):
            onNext(model.result)
        case .failure(let error):
            onError?(error)
        }
    }
    
    
}
