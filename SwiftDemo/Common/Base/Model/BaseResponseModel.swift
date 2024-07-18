//
//  BasicModel.swift
//  iOSInterviewV1
//
//  Created by june on 2024/7/10.
//

import Foundation

class BaseResponseModel<T: Decodable>: Decodable {
    let msgCode: String
    let msgContent: String
    let result: T
}
