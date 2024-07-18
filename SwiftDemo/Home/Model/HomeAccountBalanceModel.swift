//
//  HomeAccountBalanceModel.swift
//  iOSInterviewV1
//
//  Created by june on 2024/7/10.
//

import Foundation

struct HomeAccountBalanceModel: Decodable {
    var savingsList: [HomeAccountBalanceInfoModel]?
    var fixedDepositList: [HomeAccountBalanceInfoModel]?
    var digitalList: [HomeAccountBalanceInfoModel]?
}

struct HomeAccountBalanceInfoModel: Decodable {
    let account: String
    let curr: String
    let balance: Decimal
}

struct HomeAccountBindModel: Decodable {
    let usd: HomeCurrcyBalanceModel
    let khr: HomeCurrcyBalanceModel
}
