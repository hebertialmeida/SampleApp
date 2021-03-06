//
//  PreviewPhoto.swift
//  ModelGen
//
//  Generated by [ModelGen](https://github.com/hebertialmeida/ModelGen)
//  Copyright © 2020 ModelGen. All rights reserved.
//

import Foundation
import RocketData

public struct PreviewPhoto: Codable, Equatable {
    public let id: String
    public let urls: PhotoUrls

    private enum CodingKeys: String, CodingKey {
        case id
        case urls
    }
}

// MARK: - Equatable

public func == (lhs: PreviewPhoto, rhs: PreviewPhoto) -> Bool {
    guard lhs.id == rhs.id else { return false }
    guard lhs.urls == rhs.urls else { return false }
    return true
}

// MARK: - Identifiable

extension PreviewPhoto: Identifiable { }

// MARK: - RocketData

extension PreviewPhoto: Model {
    public func map(_ transform: (Model) -> Model?) -> PreviewPhoto? {
        guard let urls = transform(self.urls) as? PhotoUrls else { return nil }
        return PreviewPhoto(id: id, urls: urls)
    }

    public func forEach(_ visit: (Model) -> Void) {
        visit(urls)
    }
}