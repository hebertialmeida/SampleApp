//
//  Api.swift
//  AppStore
//
//  Created by Heberti Almeida on 2018-05-29.
//  Copyright © 2018 Heberti Almeida. All rights reserved.
//

import Alamofire

enum OrderBy: String {
    case latest
    case oldest
    case popular
}

struct Api {
    static func getPhotos(page: Int, perPage: Int, orderBy: OrderBy, completion: @escaping (Result<[Photo]>) -> Void) {
        let params: Parameters = [
            "per_page": perPage,
            "page": page,
            "order_by": orderBy
            ]

        Route.photos(params: params).request([Photo].self) { response in
            completion(response)
        }
    }

    static func getCuratedCollections(page: Int, perPage: Int, completion: @escaping (Result<[Collection]>) -> Void) {
        let params: Parameters = [
            "per_page": perPage,
            "page": page
        ]

        Route.collectionsCurated(params: params).request([Collection].self) { response in
            completion(response)
        }
    }
}
