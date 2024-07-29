//
//  BasicModel.swift
//  SwiftDemo
//
//  Created by june on 2024/7/10.
//

import Foundation

class JsonBinModel<T: Decodable>: Decodable {
    let record: BaseResponseModel<T>
    let `metadata`: BinMetadataModel
    
    enum CodingKeys: String, CodingKey {
        case record
        case `metadata`
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.record = try container.decode(BaseResponseModel.self, forKey: .record)
        self.metadata = try container.decode(BinMetadataModel.self, forKey: .metadata)
    }
}

class BaseResponseModel<T: Decodable>: Decodable {
    let msgCode: String
    let msgContent: String
    let result: T
}

class BinMetadataModel: Decodable {
    let id: String
    let `private`: Bool
    let name: String
    let collectionId: String
    let createdAt: String
}
