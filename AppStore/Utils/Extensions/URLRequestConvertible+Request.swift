//
//  URLRequestConvertible+Request.swift
//  AppStore
//
//  Created by Heberti Almeida on 2018-05-30.
//  Copyright © 2018 Heberti Almeida. All rights reserved.
//

import Foundation

enum RequestError: Error {
    case invalidData
}

extension Routeable {

    /// Create a network request and calls a result handler upon completion
    func request<T>(as type: T.Type, completion: @escaping (Result<T, Error>) -> Void) -> Void where T: Decodable {

        // Finish the request on main threat
        func end(with result: Result<T, Error>, completion: @escaping (Result<T, Error>) -> Void) {
            DispatchQueue.main.async {
                completion(result)
            }
        }

        // Decode objects
        func decode<T>(data: Data, as type: T.Type) throws -> Result<T, Error> where T: Decodable {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let response = try decoder.decode(T.self, from: data)
            return .success(response)
        }

        // Request
        do {
            let urlRequest = try asURLRequest()

            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    return end(with: .failure(error), completion: completion)
                }

                guard let data = data else {
                    return end(with: .failure(RequestError.invalidData), completion: completion)
                }

                do {
                    end(with: try decode(data: data, as: T.self), completion: completion)
                } catch {
                    end(with: .failure(error), completion: completion)
                }
            }.resume()
        } catch {
            end(with: .failure(error), completion: completion)
        }
    }
}

