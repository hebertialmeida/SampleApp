//
//  Api.swift
//  AppStore
//
//  Created by Heberti Almeida on 2018-05-29.
//  Copyright © 2018 Heberti Almeida. All rights reserved.
//

enum OrderBy: String {
    case latest
    case oldest
    case popular
}

struct Api {
    static func getPhotos(page: Int, perPage: Int, orderBy: OrderBy, completion: @escaping (Result<[Photo], Error>) -> Void) {
        let params: Parameters = [
            "per_page": perPage,
            "page": page,
            "order_by": orderBy
            ]

        Route.photos(params).request(as: [Photo].self, completion: completion)
    }

    static func getFeaturedCollections(page: Int, perPage: Int, completion: @escaping (Result<[Collection], Error>) -> Void) {
        let params: Parameters = [
            "per_page": perPage,
            "page": page
        ]

        Route.collectionsFeatured(params).request(as: [Collection].self, completion: completion)
    }
}
