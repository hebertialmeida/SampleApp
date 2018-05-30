//
//  CollectionLinks.swift
//  ModelGen
//
//  Generated by [ModelGen](https://github.com/hebertialmeida/ModelGen)
//  Copyright © 2018 ModelGen. All rights reserved.
//

import Foundation

public struct CollectionLinks: Codable, Equatable {

    // MARK: Instance Variables

    public let download: URL
    public let photos: URL
    public let html: URL

    private enum CodingKeys: String, CodingKey {
        case download
        case photos
        case html
    }
}

// MARK: - Equatable

public func == (lhs: CollectionLinks, rhs: CollectionLinks) -> Bool {
    guard lhs.download == rhs.download else { return false }
    guard lhs.photos == rhs.photos else { return false }
    guard lhs.html == rhs.html else { return false }
    return true
}