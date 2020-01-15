//
//  Diffable.swift
//  AppStore
//
//  Created by Heberti Almeida on 2018-05-31.
//  Copyright © 2018 Heberti Almeida. All rights reserved.
//

import IGListKit

public protocol Diffable: Equatable {
    var diffIdentifier: String { get }
}

public protocol DiffableBoxProtocol {
    func asDiffableBox() -> ListDiffable
}

extension DiffableBoxProtocol where Self: Diffable {
    public func asDiffableBox() -> ListDiffable {
        return DiffableBox(value: self, identifier: self.diffIdentifier as NSObjectProtocol, equal: ==)
    }
}

final class DiffableBox<T: Diffable>: ListDiffable {

    let value: T
    let identifier: NSObjectProtocol
    let equal: (T, T) -> Bool

    init(value: T, identifier: NSObjectProtocol, equal: @escaping (T, T) -> Bool) {
        self.value = value
        self.identifier = identifier
        self.equal = equal
    }

    // MARK: - IGListDiffable
    func diffIdentifier() -> NSObjectProtocol {
        return identifier
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if let other = object as? DiffableBox<T> {
            return equal(value, other.value)
        }
        return false
    }
}

extension String: Diffable {
    public var diffIdentifier: String { return self }
}

extension Int: Diffable {
    public var diffIdentifier: String { return String(self) }
}

extension Sequence where Iterator.Element: DiffableBoxProtocol {
    func asDiffableBox() -> [ListDiffable] {
        return map{$0.asDiffableBox()}
    }
}
