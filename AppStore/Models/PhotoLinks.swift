//
//  PhotoLinks.swift
//  ModelGen
//
//  Generated by [ModelGen](https://github.com/hebertialmeida/ModelGen)
//  Copyright © 2018 ModelGen. All rights reserved.
//

import Foundation

public struct PhotoLinks: Codable, Equatable {

    // MARK: Instance Variables

    public let downloadLocation: URL
    public let download: URL
    public let html: URL

    private enum CodingKeys: String, CodingKey {
        case downloadLocation = "download_location" 
        case download
        case html
    }
}

// MARK: - Equatable

public func == (lhs: PhotoLinks, rhs: PhotoLinks) -> Bool {
    guard lhs.downloadLocation == rhs.downloadLocation else { return false }
    guard lhs.download == rhs.download else { return false }
    guard lhs.html == rhs.html else { return false }
    return true
}