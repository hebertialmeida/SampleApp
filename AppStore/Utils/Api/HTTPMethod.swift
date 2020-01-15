//
//  HTTPMethod.swift
//  AppStore
//
//  Created by Heberti Almeida on 2020-01-15.
//  Copyright © 2020 Heberti Almeida. All rights reserved.
//

enum HTTPMethod: String {
    case options
    case get
    case head
    case post
    case put
    case patch
    case delete
    case trace
    case connect

    var name: String {
        return self.rawValue.uppercased()
    }
}
