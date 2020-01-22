//
//  RocketDataCacheDelegate.swift
//  AppStore
//
//  Created by Heberti Almeida on 2020-01-21.
//  Copyright © 2020 Heberti Almeida. All rights reserved.
//

import Foundation
import RocketData
import Disk

// MARK: - Cache setup

extension DataModelManager {
    /// Singleton accessor for DataModelManager
    ///
    /// See [setup](https://plivesey.github.io/RocketData/pages/040_setup.html) for more information.
    static let shared = DataModelManager(cacheDelegate: RocketDataCacheDelegate())
}

extension DataProvider {
    convenience init() {
        self.init(dataModelManager: .shared)
    }
}

extension CollectionDataProvider {
    convenience init() {
        self.init(dataModelManager: .shared)
    }
}

// MARK: - CacheDelegate

final class RocketDataCacheDelegate: CacheDelegate {

    private let directory: Disk.Directory = .caches

    public func modelForKey<T: SimpleModel>(_ cacheKey: String?, context: Any?, completion: @escaping (T?, NSError?) -> ()) {
        assert(!Thread.isMainThread)
        guard let cacheKey = cacheKey, let modelType = T.self as? Decodable.Type else {
            return completion(nil, nil)
        }

        do {
            let dataModel = try Disk.retrieve(cacheKey, from: directory, as: Data.self)
            let model = try modelType.decode(from: dataModel) as? T
            completion(model, nil)
        } catch {
            completion(nil, error as NSError)
        }
    }

    public func collectionForKey<T: SimpleModel>(_ cacheKey: String?, context: Any?, completion: @escaping ([T]?, NSError?) -> ()) {
        assert(!Thread.isMainThread)
        guard let cacheKey = cacheKey, let modelType = T.self as? Codable.Type else {
            return completion(nil, nil)
        }

        guard Disk.exists(cacheKey, in: .caches) else {
            return completion([], nil)
        }

        do {
            let collectionItems = try Disk.retrieve(cacheKey, from: directory, as: [String].self)

            // We save the models from collections seperately `collectionItems` is an array of ids.
            // We'll try to resolved each of these ids to a real object in the cache
            // If one fails, that's ok. We'll still return as much as we can
            let collection: [T] = try collectionItems.compactMap {
                let dataModel = try Disk.retrieve($0, from: directory, as: Data.self)
                return try modelType.decode(from: dataModel) as? T
            }
            completion(collection, nil)
        } catch {
            return completion(nil, error as NSError)
        }

    }

    public func setModel(_ model: SimpleModel, forKey cacheKey: String, context: Any?) {
        assert(!Thread.isMainThread)
        do {
            guard let codable = model as? Encodable else {
                fatalError("Invalid model")
            }

            let object = try codable.toData()
            try Disk.save(object, to: directory, as: cacheKey)
        } catch {
            assertionFailure("Failed to Wrap model: \(error)")
        }
    }

    public func setCollection(_ collection: [SimpleModel], forKey cacheKey: String, context: Any?) {
        assert(!Thread.isMainThread)
        // In this method, we're going to store an array of strings for the collection and cache all the models individually
        // This means updating one of the models will automatically update the collection
        for model in collection {
            guard let cacheKey = model.modelIdentifier else { continue }
            setModel(model, forKey: cacheKey, context: nil)
        }

        let collectionItems = collection.compactMap { $0.modelIdentifier }

        do {
            try Disk.save(collectionItems, to: directory, as: cacheKey)
        } catch {
            assertionFailure("Failed to save collection: \(error)")
        }
    }

    public func deleteModel(_ model: SimpleModel, forKey cacheKey: String?, context: Any?) {
        assert(!Thread.isMainThread)
        guard let cacheKey = cacheKey else { return }
        try? Disk.remove(cacheKey, from: directory)
    }
}

// MARK: Encoding & Decoding helpers

extension Encodable {
    func toData() throws -> Data {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return try encoder.encode(self)
    }
}

extension Decodable {
    static func decode(from data: Data) throws -> Self {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(self, from: data)
    }
}


/*
 This extension automatically implements `modelIdentifier` whenever the Model is `Identifiable`.
*/
extension Model where Self: Identifiable {
    public var modelIdentifier: String? {
        "\(type(of: self)):(\(self.id))"
    }
}
