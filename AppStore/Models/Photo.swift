//
//  Photo.swift
//  ModelGen
//
//  Generated by [ModelGen](https://github.com/hebertialmeida/ModelGen)
//  Copyright © 2018 ModelGen. All rights reserved.
//

import Foundation

public struct Photo: Codable {

    // MARK: Instance Variables

    public let user: User
    public let updatedAt: Date
    public let likes: Int
    public let width: Int
    public let description: String?
    public let color: String
    public let height: Int
    public let id: String
    public let createdAt: Date
    public let urls: PhotoUrls
    public let likedByUser: Bool
    public let links: PhotoLinks

    private enum CodingKeys: String, CodingKey {
        case user
        case updatedAt = "updated_at" 
        case likes
        case width
        case description
        case color
        case height
        case id
        case createdAt = "created_at" 
        case urls
        case likedByUser = "liked_by_user" 
        case links
    }
}

// MARK: - Diffable

extension Photo: Diffable, DiffableBoxProtocol {
    public var diffIdentifier: String {
        return "\(id)"
    }

    static public func == (lhs: Photo, rhs: Photo) -> Bool {
        guard lhs.user == rhs.user else { return false }
        guard lhs.updatedAt == rhs.updatedAt else { return false }
        guard lhs.likes == rhs.likes else { return false }
        guard lhs.width == rhs.width else { return false }
        guard lhs.description == rhs.description else { return false }
        guard lhs.color == rhs.color else { return false }
        guard lhs.height == rhs.height else { return false }
        guard lhs.id == rhs.id else { return false }
        guard lhs.createdAt == rhs.createdAt else { return false }
        guard lhs.urls == rhs.urls else { return false }
        guard lhs.likedByUser == rhs.likedByUser else { return false }
        guard lhs.links == rhs.links else { return false }
        return true
    }
}
