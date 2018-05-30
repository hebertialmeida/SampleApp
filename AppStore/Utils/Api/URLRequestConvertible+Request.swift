//
//  URLRequestConvertible+Request.swift
//  AppStore
//
//  Created by Heberti Almeida on 2018-05-30.
//  Copyright © 2018 Heberti Almeida. All rights reserved.
//

import Alamofire

extension URLRequestConvertible {

    func request<T>(_ type: T.Type, completion: @escaping (Result<T>) -> Void) -> Void where T: Decodable {
        Alamofire.request(self).responseData(completionHandler: { response in
            switch response.result {
            case let .success(data):
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601

                    let objects = try decoder.decode(T.self, from: data)
                    completion(Result.success(objects))
                } catch {
                    completion(Result.failure(error))
                }

            case let .failure(error):
                completion(Result.failure(error))
            }
        })
    }
}
