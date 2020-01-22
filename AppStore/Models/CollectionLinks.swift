//
//  CollectionLinks.swift
//  ModelGen
//
//  Generated by [ModelGen](https://github.com/hebertialmeida/ModelGen)
//  Copyright © 2020 ModelGen. All rights reserved.
//

import Foundation
import RocketData

public struct CollectionLinks: Codable, Equatable {
    public let download: URL?
    public let html: URL
    public let photos: URL
    public let related: URL?

    private enum CodingKeys: String, CodingKey {
        case download
        case html
        case photos
        case related
    }
}

// MARK: - Equatable

public func == (lhs: CollectionLinks, rhs: CollectionLinks) -> Bool {
    guard lhs.download == rhs.download else { return false }
    guard lhs.html == rhs.html else { return false }
    guard lhs.photos == rhs.photos else { return false }
    guard lhs.related == rhs.related else { return false }
    return true
}

// MARK: - Identifiable

extension CollectionLinks: Hashable, Identifiable {
    public var id: Int {
        self.hashValue
    }
}

// MARK: - RocketData

extension CollectionLinks: Model {
    public func map(_ transform: (Model) -> Model?) -> CollectionLinks? {
        return self
    }

    public func forEach(_ visit: (Model) -> Void) {
    }
}