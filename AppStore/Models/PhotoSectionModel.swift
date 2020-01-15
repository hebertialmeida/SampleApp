//
//  PhotoSectionModel.swift
//  ModelGen
//
//  Generated by [ModelGen](https://github.com/hebertialmeida/ModelGen)
//  Copyright © 2018 ModelGen. All rights reserved.
//

import Foundation

public struct PhotoSectionModel: Codable {

    // MARK: Instance Variables

    public let id: String
    public let date: Date
    public let photos: [Photo]

    private enum CodingKeys: String, CodingKey {
        case id
        case date
        case photos
    }
}

// MARK: - Diffable

extension PhotoSectionModel: Diffable, DiffableBoxProtocol {
    public var diffIdentifier: String {
        return "\(id)"
    }

    static public func == (lhs: PhotoSectionModel, rhs: PhotoSectionModel) -> Bool {
        guard lhs.id == rhs.id else { return false }
        guard lhs.date == rhs.date else { return false }
        guard lhs.photos == rhs.photos else { return false }
        return true
    }
}