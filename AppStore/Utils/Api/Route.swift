//
//  Route.swift
//  AppStore
//
//  Created by Heberti Almeida on 2018-05-29.
//  Copyright © 2018 Heberti Almeida. All rights reserved.
//

import Foundation

protocol Routeable {
    var method: HTTPMethod { get }
    var path: String { get }
    var baseURL: URL { get }

    func asURLRequest() throws -> URLRequest
}


extension Routeable {
    var baseURL: URL { return URL(string: "https://api.unsplash.com")! }
    var OAuthToken: String? {
        "Client-ID 9657b2982a53f8bf4b567fe7899da7354456296f0d91a2f918a1bbcfec8a021e"
    }

    var mutableURLRequest: URLRequest {
        var mutableURLRequest = URLRequest(url: baseURL.appendingPathComponent(path))
        mutableURLRequest.httpMethod = method.rawValue

        if let token = OAuthToken {
            mutableURLRequest.setValue("\(token)", forHTTPHeaderField: "Authorization")
        }
        return mutableURLRequest
    }
}

enum Route: Routeable {
    case photos(Parameters)
    case collectionsFeatured(Parameters)

    var method: HTTPMethod {
        switch self {
        case .photos,
             .collectionsFeatured:
            return .get
        }
    }

    var path: String {
        switch self {
        case .photos:
            return "/photos"
        case .collectionsFeatured:
            return "/collections/featured"
        }
    }

    func asURLRequest() throws -> URLRequest {
        switch self {
        case let .photos(params),
             let .collectionsFeatured(params):
            return try ParameterEncoder.urlEncode(mutableURLRequest, queryString: params)
        }
    }
}
