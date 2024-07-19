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
        print("⏩️ name: \(endpoint), api: \(url)")
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.addValue("$2a$10$QLn1wBwXvsg0P9Prna5AY.OP/j42HZS33YgZlxzGuEEXPbIzTRKvu", forHTTPHeaderField: "X-Access-Key")
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let jsonObject: Any = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            let jsonData: Data = try JSONSerialization.data(withJSONObject: jsonObject)
            let resultModel = try JSONDecoder().decode(JsonBinModel<T>.self, from: jsonData)
            print("⏪️ api response: \(jsonObject)")
            return .success(resultModel.record)
        }
        catch {
            print("❌ api error: \(error)")
            return .failure(error)
        }
    }
}
