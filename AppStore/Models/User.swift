//
//  User.swift
//  ModelGen
//
//  Generated by [ModelGen](https://github.com/hebertialmeida/ModelGen)
//  Copyright © 2020 ModelGen. All rights reserved.
//

import Foundation
import RocketData

/// Definition of a User
public struct User: Codable, Equatable {
    public let bio: String?
    public let id: String
    public let location: String?
    public let name: String
    public let profileImage: ProfileImage
    public let username: String

    private enum CodingKeys: String, CodingKey {
        case bio
        case id
        case location
        case name
        case profileImage = "profile_image" 
        case username
    }
}

// MARK: - Equatable

public func == (lhs: User, rhs: User) -> Bool {
    guard lhs.bio == rhs.bio else { return false }
    guard lhs.id == rhs.id else { return false }
    guard lhs.location == rhs.location else { return false }
    guard lhs.name == rhs.name else { return false }
    guard lhs.profileImage == rhs.profileImage else { return false }
    guard lhs.username == rhs.username else { return false }
    return true
}

// MARK: - Identifiable

extension User: Identifiable { }

// MARK: - RocketData

extension User: Model {
    public func map(_ transform: (Model) -> Model?) -> User? {
        guard let profileImage = transform(self.profileImage) as? ProfileImage else { return nil }
        return User(bio: bio, id: id, location: location, name: name, profileImage: profileImage, username: username)
    }

    public func forEach(_ visit: (Model) -> Void) {
        visit(profileImage)
    }
}