//
//  Route.swift
//  AppStore
//
//  Created by Heberti Almeida on 2018-05-29.
//  Copyright © 2018 Heberti Almeida. All rights reserved.
//

import Alamofire

protocol Routeable: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var baseURLString: String { get }
}

extension Routeable {
    var baseURLString: String { return "https://api.unsplash.com" }
    var OAuthToken: String? { return "Client-ID 9657b2982a53f8bf4b567fe7899da7354456296f0d91a2f918a1bbcfec8a021e" }

    var mutableURLRequest: URLRequest {
        let URL = NSURL(string: baseURLString)!
        var mutableURLRequest = URLRequest(url: URL.appendingPathComponent(path)!)
        mutableURLRequest.httpMethod = method.rawValue

        if let token = OAuthToken {
            mutableURLRequest.setValue("\(token)", forHTTPHeaderField: "Authorization")
        }
        return mutableURLRequest
    }
}

enum Route: Routeable {
    case photos(params: Parameters)
    case collectionsCurated(params: Parameters)

    var method: HTTPMethod {
        switch self {
        case .photos,
             .collectionsCurated:
            return .get
        }
    }

    var path: String {
        switch self {
        case .photos:
            return "/photos"
        case .collectionsCurated:
            return "/collections/curated"
        }
    }

    func asURLRequest() throws -> URLRequest {
        switch self {
        case let .photos(params),
             let .collectionsCurated(params):
            return try URLEncoding.default.encode(mutableURLRequest, with: params)
        }
    }
}
