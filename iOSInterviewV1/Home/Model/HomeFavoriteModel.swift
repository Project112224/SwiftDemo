//
//  HomeFavoriteModel.swift
//  iOSInterviewV1
//
//  Created by june on 2024/7/10.
//

import Foundation

struct HomeFavoriteModel: Decodable {
    let favoriteList: [HomeFavoriteInfoModel]
}

struct HomeFavoriteInfoModel: Decodable {
    let nickname: String
    let transType: String
}
