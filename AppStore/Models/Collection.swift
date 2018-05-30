//
//  Collection.swift
//  ModelGen
//
//  Generated by [ModelGen](https://github.com/hebertialmeida/ModelGen)
//  Copyright © 2018 ModelGen. All rights reserved.
//

import Foundation

public struct Collection: Codable, Equatable {

    // MARK: Instance Variables

    public let curated: Bool
    public let publishedAt: Date
    public let previewPhotos: [PreviewPhoto]
    public let updatedAt: Date
    public let id: Int
    public let user: User
    public let featured: Bool
    public let description: String?
    public let title: String
    public let links: CollectionLinks
    public let totalPhotos: Int
    public let coverPhoto: Photo

    private enum CodingKeys: String, CodingKey {
        case curated
        case publishedAt = "published_at" 
        case previewPhotos = "preview_photos" 
        case updatedAt = "updated_at" 
        case id
        case user
        case featured
        case description
        case title
        case links
        case totalPhotos = "total_photos" 
        case coverPhoto = "cover_photo" 
    }
}

// MARK: - Equatable

public func == (lhs: Collection, rhs: Collection) -> Bool {
    guard lhs.curated == rhs.curated else { return false }
    guard lhs.publishedAt == rhs.publishedAt else { return false }
    guard lhs.previewPhotos == rhs.previewPhotos else { return false }
    guard lhs.updatedAt == rhs.updatedAt else { return false }
    guard lhs.id == rhs.id else { return false }
    guard lhs.user == rhs.user else { return false }
    guard lhs.featured == rhs.featured else { return false }
    guard lhs.description == rhs.description else { return false }
    guard lhs.title == rhs.title else { return false }
    guard lhs.links == rhs.links else { return false }
    guard lhs.totalPhotos == rhs.totalPhotos else { return false }
    guard lhs.coverPhoto == rhs.coverPhoto else { return false }
    return true
}