//
//  ParameterEncoder.swift
//  AppStore
//
//  Created by Heberti Almeida on 2020-01-15.
//  Copyright © 2020 Heberti Almeida. All rights reserved.
//

import Foundation

typealias Parameters = [String: Any]

enum EncodingError: Error {
    case missingURL
}

struct ParameterEncoder {

    static func urlEncode(_ urlRequest: URLRequest, queryString: Parameters) throws -> URLRequest {
        var urlRequest = urlRequest

        guard let url = urlRequest.url else {
            throw EncodingError.missingURL
        }

        let query = queryString.map({ URLQueryItem(name: $0.key, value: "\($0.value)") })

        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !queryString.isEmpty {
            urlComponents.queryItems = (urlComponents.queryItems ?? []) + query
            urlRequest.url = urlComponents.url
        }

        return urlRequest
    }

    static func JSONEncode(_ urlRequest: URLRequest, parameters: Parameters?) throws -> URLRequest {
        var urlRequest = urlRequest
        guard let parameters = parameters else { return urlRequest }

        let data = try JSONSerialization.data(withJSONObject: parameters, options: [])
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = data

        return urlRequest
    }
}
