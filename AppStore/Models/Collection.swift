//
//  Collection.swift
//  ModelGen
//
//  Generated by [ModelGen](https://github.com/hebertialmeida/ModelGen)
//  Copyright © 2020 ModelGen. All rights reserved.
//

import Foundation
import RocketData

public struct Collection: Codable, Equatable {
    public let coverPhoto: Photo
    public let curated: Bool
    public let description: String?
    public let featured: Bool
    public let id: Int
    public let links: CollectionLinks
    public let previewPhotos: [PreviewPhoto]
    public let publishedAt: Date
    public let title: String
    public let totalPhotos: Int
    public let updatedAt: Date
    public let user: User

    private enum CodingKeys: String, CodingKey {
        case coverPhoto = "cover_photo" 
        case curated
        case description
        case featured
        case id
        case links
        case previewPhotos = "preview_photos" 
        case publishedAt = "published_at" 
        case title
        case totalPhotos = "total_photos" 
        case updatedAt = "updated_at" 
        case user
    }
}

// MARK: - Equatable

public func == (lhs: Collection, rhs: Collection) -> Bool {
    guard lhs.coverPhoto == rhs.coverPhoto else { return false }
    guard lhs.curated == rhs.curated else { return false }
    guard lhs.description == rhs.description else { return false }
    guard lhs.featured == rhs.featured else { return false }
    guard lhs.id == rhs.id else { return false }
    guard lhs.links == rhs.links else { return false }
    guard lhs.previewPhotos == rhs.previewPhotos else { return false }
    guard lhs.publishedAt == rhs.publishedAt else { return false }
    guard lhs.title == rhs.title else { return false }
    guard lhs.totalPhotos == rhs.totalPhotos else { return false }
    guard lhs.updatedAt == rhs.updatedAt else { return false }
    guard lhs.user == rhs.user else { return false }
    return true
}

// MARK: - Identifiable

extension Collection: Identifiable { }

// MARK: - RocketData

extension Collection: Model {
    public func map(_ transform: (Model) -> Model?) -> Collection? {
        guard let coverPhoto = transform(self.coverPhoto) as? Photo else { return nil }
        guard let links = transform(self.links) as? CollectionLinks else { return nil }
        let previewPhotos = self.previewPhotos.compactMap { transform($0) as? PreviewPhoto }
        guard let user = transform(self.user) as? User else { return nil }
        return Collection(coverPhoto: coverPhoto, curated: curated, description: description, featured: featured, id: id, links: links, previewPhotos: previewPhotos, publishedAt: publishedAt, title: title, totalPhotos: totalPhotos, updatedAt: updatedAt, user: user)
    }

    public func forEach(_ visit: (Model) -> Void) {
        visit(coverPhoto)
        visit(links)
        previewPhotos.forEach(visit)
        visit(user)
    }
}