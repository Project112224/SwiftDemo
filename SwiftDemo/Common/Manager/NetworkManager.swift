//
//  NetworkManager.swift
//  iOSInterviewV1
//
//  Created by june on 2024/7/10.
//

import Foundation

enum HttpMethodType: String {
    case get = "GET"
    case post = "POST"
}

enum HttpError: Error {
    case urlError
}

class NetworkManager {
    static func getMethod<T: Decodable>(endpoint: Endpoint, httpMethod: HttpMethodType = .get, model: T.Type) async -> Result<BaseResponseModel<T>, Error> {
        guard let url = URL(string: endpoint.urlString) else {
            return .failure(HttpError.urlError)
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let jsonObject = try JSONSerialization.jsonObject(with: data)
            let jsonData = try JSONSerialization.data(withJSONObject: jsonObject)
            let resultModel = try JSONDecoder().decode(BaseResponseModel<T>.self, from: jsonData)
            return .success(resultModel)
        }
        catch {
            return .failure(error)
        }
    }
}
