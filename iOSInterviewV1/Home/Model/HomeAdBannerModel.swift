//
//  HomeAdBannerModel.swift
//  iOSInterviewV1
//
//  Created by june on 2024/7/10.
//

import Foundation

struct HomeAdBannerModel: Decodable {
    let bannerList: [HomeAdBannerInfoModel]
}

struct HomeAdBannerInfoModel: Decodable {
    let adSeqNo: Int
    let linkUrl: String
}
